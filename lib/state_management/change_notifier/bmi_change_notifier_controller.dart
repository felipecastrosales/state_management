import 'dart:math';

import 'package:flutter/material.dart';

class BMIChangeNotifierController extends ChangeNotifier {
  var bmi = 0.0;
  Future<void> calculateBMI({
    required double height,
    required double weight,
  }) async {
    bmi = 0;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    bmi = weight / pow(height, 2);
    notifyListeners();
  }
}
