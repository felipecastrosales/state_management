import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:state_management/widgets/bmi_gauge_range.dart';

class BMISetStatePage extends StatefulWidget {
  const BMISetStatePage({Key? key}) : super(key: key);

  @override
  _BMISetStatePageState createState() => _BMISetStatePageState();
}

class _BMISetStatePageState extends State<BMISetStatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI | SetState'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SfRadialGauge(
                axes: [
                  RadialAxis(
                    showLabels: true,
                    showTicks: false,
                    showAxisLine: false,
                    minimum: 12.5,
                    maximum: 47.9,
                    ranges: [
                      BMIGaugeRange(
                        color: Colors.blue,
                        start: 12.5,
                        end: 18.5,
                        label: 'Thinness',
                      ),
                      BMIGaugeRange(
                        color: Colors.green,
                        start: 18.5,
                        end: 24.5,
                        label: 'Normal',
                      ),
                      BMIGaugeRange(
                        color: Colors.yellow[600]!,
                        start: 24.5,
                        end: 29.9,
                        label: 'Overweight',
                      ),
                      BMIGaugeRange(
                        color: Colors.red[500]!,
                        start: 29.9,
                        end: 39.9,
                        label: 'Obesity',
                      ),
                      BMIGaugeRange(
                        color: Colors.red[900]!,
                        start: 39.9,
                        end: 47.9,
                        label: 'Severe Obesity',
                      ),
                    ],
                    pointers: const [
                      NeedlePointer(
                        value: 15,
                        enableAnimation: true,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
