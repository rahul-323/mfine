import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/lab_test_card.dart';

class LabTestScreen extends StatelessWidget {
  const LabTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tests = const [
      ('Complete Blood Count', 'CBC • Home collection available', 399, 499, '20% OFF'),
      ('Thyroid Profile', 'T3, T4, TSH', 499, 699, '29% OFF'),
      ('Lipid Profile', 'Cholesterol & heart health', 599, 799, '25% OFF'),
      ('HbA1c', 'Average blood sugar', 299, 399, '25% OFF'),
      ('Vitamin D', 'Vitamin D3 test', 699, 899, '22% OFF'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Tests')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          children: [
            const Text('600+ trusted labs', style: TextStyle(color: AppConstants.tealDark, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Book tests at home or nearby', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
            const SizedBox(height: 18),
            ...tests.map((t) => LabTestCard(name: t.$1, subtitle: t.$2, price: t.$3, oldPrice: t.$4, discount: t.$5)),
          ],
        ),
      ),
    );
  }
}
