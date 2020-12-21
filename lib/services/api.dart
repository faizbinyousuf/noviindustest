import 'package:flutter/services.dart';

class Api{
  static  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data.json');
  }
}