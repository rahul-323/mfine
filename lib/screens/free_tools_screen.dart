import 'package:flutter/material.dart';
import '../core/constants.dart';

class FreeToolsScreen extends StatelessWidget {
  const FreeToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = const [
      (
        'BMI Calculator',
        'Know your healthy BMI range',
        Icons.monitor_weight_outlined,
        Color(0xFF7B61FF)
      ),
      (
        'Water Intake',
        'Estimate daily hydration',
        Icons.water_drop_outlined,
        Color(0xFF1597E5)
      ),
      (
        'Step Counter',
        'Track your movement goals',
        Icons.directions_walk_outlined,
        Color(0xFF00A676)
      ),
      (
        'Health Risk Check',
        'Quick lifestyle screening',
        Icons.health_and_safety_outlined,
        Color(0xFFFF6B5B)
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Free Tools')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 100),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFE9FAFC), Color(0xFFF5FFFF)]),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Small checks, better awareness.',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    Text('Explore free wellness tools for everyday use.',
                        style: TextStyle(color: AppConstants.muted)),
                  ]),
            ),
            const SizedBox(height: 18),
            ...tools.map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE4ECEF)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x0B000000),
                              blurRadius: 14,
                              offset: Offset(0, 7))
                        ]),
                    child: Row(children: [
                      Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(
                              color: t.$4.withValues(alpha: .12),
                              borderRadius: BorderRadius.circular(16)),
                          child: Icon(t.$3, color: t.$4, size: 30)),
                      const SizedBox(width: 14),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(t.$1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text(t.$2,
                                style: const TextStyle(
                                    color: AppConstants.muted, fontSize: 13)),
                          ])),
                      const Icon(Icons.chevron_right_rounded),
                    ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
