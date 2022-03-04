import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/bloc/json_bloc/json_event.dart';
import 'package:meme_generator/bloc/json_bloc/json_state.dart';
import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/screens/widgets/text_element.dart';
import 'package:meme_generator/resource/input_json.dart';
import 'package:meme_generator/utils/widget_manager.dart';

class JsonBloc extends Bloc<JsonEvent, JsonState> {
  JsonBloc() : super(JsonState()) {
    on<FetchJsonEvent>(_mapFetchJsonEventToState);
    on<ChangeJsonValueEvent>(_mapChangeJsonValueEventToState);
  }
  Canvas? canvas;
  List<TextElementWidget>? textElements = [];
  void _mapFetchJsonEventToState(
      FetchJsonEvent event, Emitter<JsonState> emit) async {
    emit(FetchJsonLoadingState());
    try {
      Canvas canvasData = WidgetManager().parseJson(inputJson);
      List<TextElementWidget>? textElementsData =
          WidgetManager().createElements(canvasData);
      canvas = canvasData;
      textElements = textElementsData;
      emit(FetchJsonCompletedState(
          canvas: canvasData, textElements: textElements));
    } catch (error) {
      emit(FetchJsonErrorState());
    }
  }

  void _mapChangeJsonValueEventToState(
      ChangeJsonValueEvent event, Emitter<JsonState> emit) async {
    print(event.elementData?.id);
    print(event.elementData?.text);
    print(event.elementData?.position?.x);
    textElements?.forEach((element) {
      if (element.textElementData.id == event.elementData?.id) {
        element.textElementData = event.elementData!;
      }
    });

    emit(ChangeJsonValueState());
  }
}
