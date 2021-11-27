import 'dart:async';
import 'dart:math';

import 'bmi_state.dart';

class BMIBlocPatternController {
  final _bmiStreamController = StreamController<BMIState>.broadcast()
    ..add(
      BMIState(bmi: 0),
    );

  Stream<BMIState> get bmiOut => _bmiStreamController.stream;

  Future<void> calculateBMI({
    required double weight,
    required double height,
  }) async {
    try {
      _bmiStreamController.add(
        BMIStateLoading(),
      );
      await Future.delayed(
        const Duration(seconds: 1),
      );
      final bmi = weight / pow(height, 2);
      //throw Exception();
      _bmiStreamController.add(
        BMIState(bmi: bmi),
      );
    } on Exception {
      _bmiStreamController.add(
        BMIStateError(message: 'Error to calculate BMI'),
      );
    }
  }

  void dispose() {
    _bmiStreamController.close();
  }
}
