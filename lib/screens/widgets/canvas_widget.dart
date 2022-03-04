import 'package:flutter/material.dart';
import 'package:meme_generator/models/canvas.dart';
import 'package:meme_generator/screens/widgets/text_element.dart';
import 'package:meme_generator/utils/locator.dart';
import 'package:meme_generator/utils/widget_manager.dart';

class CanvasWidget extends StatelessWidget {
  CanvasWidget({Key? key, this.canvasData, this.textElements})
      : super(key: key);
  Canvas? canvasData;
  List<TextElementWidget>? textElements;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Image.network(canvasData?.imageUrl ?? ""),
          ...textElements ?? []
        ],
      ),
    );
  }
}
