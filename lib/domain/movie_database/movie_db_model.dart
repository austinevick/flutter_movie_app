import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class ModelDBModel {
  int? id;
  final String? image;
  final String? title;
  final bool? isFavourite;
  ModelDBModel({
    this.id,
    this.image,
    this.title,
    this.isFavourite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'isFavourite': isFavourite! ? 0 : 1,
    };
  }

  factory ModelDBModel.fromMap(Map<String, dynamic> map) {
    return ModelDBModel(
      id: map['id']?.toInt(),
      image: map['image'],
      title: map['title'],
      isFavourite: map['isFavourite'] == 0,
    );
  }
}

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
