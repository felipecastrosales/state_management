class BMIState {
  final double? bmi;
  BMIState({this.bmi});
}

class BMIStateLoading extends BMIState {}

class BMIStateError extends BMIState {
  String message;
  BMIStateError({
    required this.message,
  });
}
