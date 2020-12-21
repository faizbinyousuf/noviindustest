import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testnovi/model/category.dart';
import 'package:testnovi/services/api.dart';

class CategoryProvider with ChangeNotifier {
  bool isLoading = false;
  List<Data> datas;
  int _tabLength = 0;
  get getLength => _tabLength;

  fetchData(BuildContext context) {
    isLoading = true;

    Api.loadAsset().then((value) {
      this.datas = dataFromJson(value);
      _tabLength = datas.length;
      isLoading = false;

      notifyListeners();
    });

    return datas;
  }
}
