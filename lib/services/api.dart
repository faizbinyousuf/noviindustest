import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Api {
  static  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data.json');

  }
}