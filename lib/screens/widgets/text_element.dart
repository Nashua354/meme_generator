import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meme_generator/bloc/json_bloc/json_bloc.dart';
import 'package:meme_generator/bloc/json_bloc/json_event.dart';
import 'package:meme_generator/bloc/json_bloc/json_state.dart';
import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/utils/locator.dart';
import 'package:meme_generator/utils/mixed_utils.dart';

class TextElementWidget extends StatefulWidget {
  TextElementWidget({Key? key, required this.textElementData})
      : super(key: key);

  TextElement textElementData;

  @override
  _TextElementWidgetState createState() => _TextElementWidgetState();
}

class _TextElementWidgetState extends State<TextElementWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JsonBloc, JsonState>(
        bloc: getIt.get<JsonBloc>(),
        buildWhen: (_, state) => ((state is! FetchJsonCompletedState) ||
            (state is! FetchJsonLoadingState)),
        builder: (context, state) {
          return Positioned(
            top: widget.textElementData.position?.y,
            left: widget.textElementData.position?.x,
            child: GestureDetector(
              onPanEnd: (details) {
                getIt.get<JsonBloc>().add(
                    ChangeJsonValueEvent(elementData: widget.textElementData));
              },
              onPanUpdate: (d) {
                setState(() {
                  widget.textElementData.position?.x =
                      (widget.textElementData.position?.x ?? 0) + d.delta.dx;
                  widget.textElementData.position?.y =
                      (widget.textElementData.position?.y ?? 0) + d.delta.dy;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(
                  widget.textElementData.text ?? '',
                  style: TextStyle(
                    fontSize: widget.textElementData.fontSize,
                    color: hexToColor(widget.textElementData.textColor),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
