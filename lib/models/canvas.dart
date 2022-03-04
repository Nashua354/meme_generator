// To parse this JSON data, do
//
//     final canvas = canvasFromJson(jsonString);

import 'dart:convert';

Canvas canvasFromJson(String str) => Canvas.fromJson(json.decode(str));

String canvasToJson(Canvas data) => json.encode(data.toJson());

class Canvas {
  Canvas({
    this.memeId,
    this.imageUrl,
    this.elements,
  });

  String? memeId;
  String? imageUrl;
  List<TextElement>? elements;

  factory Canvas.fromJson(Map<String, dynamic> json) => Canvas(
        memeId: json["meme_id"],
        imageUrl: json["imageUrl"],
        elements: List<TextElement>.from(
            json["elements"].map((x) => TextElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meme_id": memeId,
        "imageUrl": imageUrl,
        "elements": List<dynamic>.from(elements!.map((x) => x.toJson())),
      };
}

class TextElement {
  TextElement(
      {this.type,
      this.position,
      this.text,
      this.fontSize,
      this.textColor,
      this.stickerId,
      this.id});
  int? id;
  String? type;
  Position? position;
  String? text;
  double? fontSize;
  String? textColor;
  String? stickerId;

  factory TextElement.fromJson(Map<String, dynamic> json) => TextElement(
        type: json["type"],
        position: Position.fromJson(json["position"]),
        text: json["text"],
        fontSize: json["fontSize"],
        textColor: json["textColor"],
        stickerId: json["sticker-id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "position": position!.toJson(),
        "text": text,
        "fontSize": fontSize,
        "textColor": textColor,
        "sticker-id": stickerId,
        "id": id,
      };
}

class Position {
  Position({
    this.x,
    this.y,
  });

  double? x;
  double? y;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
