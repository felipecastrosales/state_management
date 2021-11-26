import 'dart:async';
import 'dart:math';

import 'bmi_state.dart';

class BMIBlocPatternController {
  final _bmiStreamController = StreamController<BMIState>()
    ..add(
      BMIState(bmi: 0),
    );

  Stream<BMIState> get bmiOut => _bmiStreamController.stream;

  Future<void> calculateBMI({
    required double weight,
    required double height,
  }) async {
    _bmiStreamController.add(
      BMIState(bmi: 0),
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final bmi = weight / pow(height, 2);
    _bmiStreamController.add(
      BMIState(bmi: bmi),
    );
  }

  void dispose() {
    _bmiStreamController.close();
  }
}
