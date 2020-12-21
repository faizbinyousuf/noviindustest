// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<Data> dataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String dataToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  Data({
    this.category,
    this.imageBanner,
    this.subCategory,
  });

  String category;
  String imageBanner;
  List<SubCategory> subCategory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"],
    imageBanner: json["imageBanner"],
    subCategory: List<SubCategory>.from(
        json["subCategory"].map((x) => SubCategory.fromJson(x))),
  );



  Map<String, dynamic> toJson() => {
    "category": category,
    "imageBanner": imageBanner,
    "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    this.subcatName,
    this.subcatImage,
  });

  String subcatName;
  String subcatImage;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    subcatName: json["subcatName"],
    subcatImage: json["subcatImage"],
  );

  Map<String, dynamic> toJson() => {
    "subcatName": subcatName,
    "subcatImage": subcatImage,
  };
}
