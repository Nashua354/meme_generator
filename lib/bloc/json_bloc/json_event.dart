import 'package:meme_generator/bloc/base/base_event.dart';
import 'package:meme_generator/models/canvas.dart';

class JsonEvent extends BaseEvent {}

class FetchJsonEvent extends JsonEvent {}

class ChangeJsonValueEvent extends JsonEvent {
  TextElement? elementData;
  ChangeJsonValueEvent({this.elementData});
}
