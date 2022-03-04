import 'package:meme_generator/bloc/base/base_state.dart';
import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/screens/widgets/text_element.dart';

class JsonState extends BaseState {}

class FetchJsonLoadingState extends JsonState {}

class FetchJsonCompletedState extends JsonState {
  Canvas? canvas;
  List<TextElementWidget>? textElements;
  FetchJsonCompletedState({this.canvas, this.textElements});
}

class FetchJsonErrorState extends JsonState {}

class ChangeJsonValueState extends JsonState {}
