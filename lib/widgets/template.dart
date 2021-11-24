import 'dart:math';

import 'package:flutter/material.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

import 'bmi_gauge.dart';

class BMISetStatePage extends StatefulWidget {
  const BMISetStatePage({Key? key}) : super(key: key);

  @override
  _BMISetStatePageState createState() => _BMISetStatePageState();
}

class _BMISetStatePageState extends State<BMISetStatePage> {
  final formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  var bmi = 0.0;

  Future<void> _calculateBMI({
    required double weight,
    required double height,
  }) async {
    setState(() {
      bmi = 0.0;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      bmi = weight / pow(height, 2);
    });
  }


  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI | SetState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BMIGauge(bmi: bmi),
                const SizedBox(height: 20),
                TextFormField(
                  controller: weightController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Weight';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  onChanged: (String value) {},
                ),
                TextFormField(
                  controller: heightController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Height';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  onChanged: (String value) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      double weight =
                          formatter.parse(weightController.text) as double;
                      double height =
                          formatter.parse(heightController.text) as double;
                      _calculateBMI(
                        weight: weight,
                        height: height,
                      );
                    }
                  },
                  child: const Text('Calculate BMI'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
