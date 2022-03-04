import 'dart:convert';

import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/screens/widgets/text_element.dart';

class WidgetManager {
  Canvas parseJson(String jsonData) {
    Canvas canvas = Canvas.fromJson(json.decode(jsonData));
    return canvas;
  }

  List<TextElementWidget>? createElements(Canvas canvasData) {
    List<TextElementWidget>? textElements = [];
    canvasData.elements?.forEach((element) {
      switch (element.type) {
        case "text":
          textElements.add(TextElementWidget(
            textElementData: element,
          ));
          break;
        default:
      }
    });
    return textElements;
  }
}
