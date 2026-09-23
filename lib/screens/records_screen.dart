import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Dr. Prem Prakash Bansal',
        '7 Sep 2026 • Case Closed',
        'Completed',
        'Order Medicines'
      ),
      (
        'Dr. Prem Prakash Bansal',
        '02 Dec 2025 • Case Closed',
        'Completed',
        'Order Medicines'
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('My Consultations')),
      backgroundColor: const Color(0xFF0B1120),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 28),
          children: [
            ...items.map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                              child: Text("Disha Sankneniwar's consultation...",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16))),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 6),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE7F4F7),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(e.$3,
                                  style: const TextStyle(
                                      color: AppConstants.tealDark,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11))),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFFEAF8FC),
                              child: Icon(Icons.person,
                                  color: AppConstants.tealDark)),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(e.$1,
                                    style: const TextStyle(
                                        color: AppConstants.tealDark,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(e.$2,
                                    style: const TextStyle(
                                        color: AppConstants.muted,
                                        fontSize: 12)),
                              ])),
                        ]),
                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton(
                            onPressed: e.$3 == 'Completed'
                                ? () => context.push(
                                      '/consult-room',
                                      extra: e.$2.startsWith('02 Dec'),
                                    )
                                : null,
                            style: FilledButton.styleFrom(
                                backgroundColor: AppConstants.coral,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 12)),
                            child:
                                Text(e.$3 == 'Completed' ? 'Open Chat' : e.$4),
                          ),
                        ),
                      ]),
                )),
            const SizedBox(height: 180),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Home'))),
            const SizedBox(width: 10),
            Expanded(
                child: FilledButton(
                    onPressed: () =>
                        showComingSoonDialog(context, 'Starting a new case'),
                    style: FilledButton.styleFrom(
                        backgroundColor: AppConstants.coral,
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('New Case'))),
          ]),
        ),
      ),
    );
  }
}
