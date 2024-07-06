import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi/core/app_constants.dart';
import 'package:bmi/widgets/bmi_gauge.dart';

import 'bmi_bloc_pattern_controller.dart';
import 'bmi_state.dart';

class BMIBlocPatternPage extends StatefulWidget {
  const BMIBlocPatternPage({super.key});

  @override
  State<BMIBlocPatternPage> createState() => _BMIBlocPatternPageState();
}

class _BMIBlocPatternPageState extends State<BMIBlocPatternPage> {
  final controller = BMIBlocPatternController();
  final formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI | BlocPattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<BMIState>(
                  stream: controller.bmiOut,
                  builder: (context, snapshot) {
                    var bmi = snapshot.data?.bmi ?? 0;
                    return BMIGauge(bmi: bmi);
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder<BMIState>(
                  stream: controller.bmiOut,
                  builder: (context, snapshot) {
                    final dataValue = snapshot.data;
                    if (dataValue is BMIStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (dataValue is BMIStateError) {
                      return Text(dataValue.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                TextFormField(
                  controller: weightController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Weight';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  inputFormatters: AppConstants.bmiInputFormatterr,
                  onChanged: (String value) {},
                ),
                TextFormField(
                  controller: heightController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory Height';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height'),
                  inputFormatters: AppConstants.bmiInputFormatterr,
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
                      controller.calculateBMI(
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
