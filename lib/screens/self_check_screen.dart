import 'package:flutter/material.dart';
import '../core/constants.dart';

class SelfCheckScreen extends StatefulWidget {
  const SelfCheckScreen({super.key});
  @override
  State<SelfCheckScreen> createState() => _SelfCheckScreenState();
}

class _SelfCheckScreenState extends State<SelfCheckScreen> {
  int _step = 0;
  final questions = const [
    ('What are you feeling today?', ['Cough', 'Fever', 'Headache', 'Fatigue']),
    (
      'How long has it been?',
      ['Today', '1–3 days', '4–7 days', 'More than a week']
    ),
    ('Any warning signs?', ['No', 'Mild', 'Moderate', 'Severe']),
  ];

  @override
  Widget build(BuildContext context) {
    final item = questions[_step];
    return Scaffold(
      appBar: AppBar(title: const Text('Self Check')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            LinearProgressIndicator(
                value: (_step + 1) / questions.length,
                minHeight: 8,
                borderRadius: BorderRadius.circular(99)),
            const SizedBox(height: 22),
            Text('Quick health questionnaire',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text(
                'Answer a few simple questions. This does not provide medical advice.',
                style: TextStyle(color: AppConstants.muted)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: const Color(0xFFEAF8FC),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Question ${_step + 1} of ${questions.length}',
                        style: const TextStyle(
                            color: AppConstants.tealDark,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Text(item.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 22)),
                  ]),
            ),
            const SizedBox(height: 14),
            RadioGroup<String>(
              groupValue: null,
              onChanged: (_) => setState(() {}),
              child: Column(
                children: [
                  ...item.$2.map((o) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RadioListTile<String>(
                          value: o,
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: const BorderSide(color: Color(0xFFE3ECEF))),
                          title: Text(o),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () =>
                  setState(() => _step = (_step + 1) % questions.length),
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15)),
              child: Text(
                  _step == questions.length - 1 ? 'Restart Check' : 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
