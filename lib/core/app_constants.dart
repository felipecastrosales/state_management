import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static final bmiInputFormatterr = [
    CurrencyTextInputFormatter(
      NumberFormat.currency(
        locale: 'pt_BR',
        symbol: '',
        decimalDigits: 2,
      ),
    ),
  ];
}
