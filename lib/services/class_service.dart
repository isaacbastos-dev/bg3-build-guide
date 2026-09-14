import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/bg3_class.dart';

class ClassService {
  Future<List<Bg3Class>> carregarClasses() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/classes.json');

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((item) => Bg3Class.fromJson(item))
        .toList();
  }
}