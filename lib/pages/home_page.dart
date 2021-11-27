import 'package:flutter/material.dart';

import 'package:state_management/state_management/bloc_pattern/bmi_bloc_pattern_page.dart';
import 'package:state_management/state_management/change_notifier/bmi_change_notifier_page.dart';
import 'package:state_management/state_management/setState/bmi_set_state_page.dart';
import 'package:state_management/state_management/value_notifier/bmi_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(
                context,
                const BMISetStatePage(),
              ),
              child: const Text('setState'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToPage(
                context,
                const BMIValueNotifierPage(),
              ),
              child: const Text('ValueNotifier'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToPage(
                context,
                const BMIChangeNotifierPage(),
              ),
              child: const Text('ChangeNotifier'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToPage(
                context,
                const BMIBlocPatternPage(),
              ),
              child: const Text('BLoC Pattern | Streams'),
            ),
          ],
        ),
      ),
    );
  }
}
