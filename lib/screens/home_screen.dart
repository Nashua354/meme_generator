import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/bloc/json_bloc/json_bloc.dart';
import 'package:meme_generator/bloc/json_bloc/json_event.dart';
import 'package:meme_generator/bloc/json_bloc/json_state.dart';
import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/screens/widgets/canvas_widget.dart';
import 'package:meme_generator/screens/widgets/text_element.dart';
import 'package:meme_generator/resource/input_json.dart';
import 'package:meme_generator/utils/locator.dart';
import 'package:meme_generator/utils/widget_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getIt.get<JsonBloc>().add(FetchJsonEvent());
    super.initState();
  }

  List<TextEditingController> editingControllers = [];
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meme Generator'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await _saveMeme();
                  _saveJson(getIt.get<JsonBloc>().canvas);
                },
                child: const Icon(Icons.save),
              )),
        ],
      ),
      body: BlocBuilder<JsonBloc, JsonState>(
          bloc: getIt.get<JsonBloc>(),
          buildWhen: (_, state) => (state is! ChangeJsonValueState),
          builder: (context, state) {
            if (state is FetchJsonLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchJsonCompletedState) {
              populateControllers(state.textElements);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    RepaintBoundary(
                      key: _globalKey,
                      child: CanvasWidget(
                        canvasData: state.canvas,
                        textElements: state.textElements,
                      ),
                    ),
                    ...List.generate(
                        state.textElements?.length ?? 0,
                        (index) => TextField(
                              onChanged: (value) {
                                state.textElements?[index].textElementData
                                    .text = value;
                                getIt.get<JsonBloc>().add(ChangeJsonValueEvent(
                                    elementData: state
                                        .textElements?[index].textElementData));
                              },
                              controller: editingControllers[index],
                            ))
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  populateControllers(List<TextElementWidget>? elements) {
    editingControllers = [];
    elements?.forEach((element) {
      editingControllers
          .add(TextEditingController(text: element.textElementData.text));
    });
  }

  _saveMeme() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData?>);
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print(result);
    }
  }

  _saveJson(Canvas? canvasData) {
    inputJson = (canvasToJson(canvasData!));
    //Save Json to DB
    print(inputJson);
  }
}
