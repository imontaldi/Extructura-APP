// Dart imports:
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

class ImageModel {
  final int? id;
  final String? path;
  final String? url;
  final Uint8List? convertedImage;

  ImageModel({this.id, this.path, this.url, this.convertedImage});

  factory ImageModel.fromMap(Map<String, dynamic> json) {
    try {
      return ImageModel(
        id: json['imageId']?.toInt(),
        path: json['path'],
        url: json['imageUrl'],
      );
    } catch (ex) {
      log("${ex}fromMap ImageModel:${json['imageId']}");
      return ImageModel();
    }
  }

  Map<String, dynamic> toMap() => {
        "imageId": id,
        "path": path,
        "imageUrl": url,
      };

  Map<String, dynamic> toApi() => {
        "imageId": url != null ? "$id" : null,
        "fileName": "$id.jpg",
        "mimeType": "image/jpeg",
        "base64": getBase64(),
      };

  getBase64() {
    if (url != null) {
      return null;
    }

    if (path != null) {
      File img = File.fromUri(Uri.parse(path!));
      var bytes = img.readAsBytesSync();
      var result = base64.encode(bytes);
      return result;
    } else {
      return null;
    }
    //return 'base64encodedHere';
  }
}
