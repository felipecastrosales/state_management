import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi/core/app_constants.dart';
import 'package:bmi/widgets/bmi_gauge.dart';

import 'bmi_change_notifier_controller.dart';

class BMIChangeNotifierPage extends StatefulWidget {
  const BMIChangeNotifierPage({super.key});

  @override
  State<BMIChangeNotifierPage> createState() => _BMIChangeNotifierPageState();
}

class _BMIChangeNotifierPageState extends State<BMIChangeNotifierPage> {
  final controller = BMIChangeNotifierController();
  final formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI | ValueNotifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    print('build | AnimatedBuilder');
                    return BMIGauge(bmi: controller.bmi);
                  },
                ),
                const SizedBox(height: 20),
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
