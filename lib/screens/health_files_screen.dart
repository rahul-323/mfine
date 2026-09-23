import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';

class HealthFilesScreen extends StatelessWidget {
  const HealthFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Files'), actions: [
        IconButton(
            onPressed: () => showComingSoonDialog(context, 'File search'),
            icon: const Icon(Icons.search))
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showComingSoonDialog(context, 'File upload'),
        backgroundColor: AppConstants.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 110),
          children: [
            _file(context, 'Prescription - Dr. Prem Prakash', '07 Sep 2026',
                Icons.receipt_long_outlined),
            _file(context, 'Chest X-Ray Report', '12 Sep 2026',
                Icons.image_outlined),
            _file(context, 'CBC Lab Report', '07 Sep 2026',
                Icons.description_outlined),
            _file(context, 'Insurance Document', '30 Aug 2026',
                Icons.shield_outlined),
          ],
        ),
      ),
    );
  }

  Widget _file(BuildContext context, String title, String date, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE3EAED))),
      child: Row(children: [
        Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
                color: const Color(0xFFEAF8FC),
                borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: AppConstants.tealDark)),
        const SizedBox(width: 13),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(date,
              style: const TextStyle(color: AppConstants.muted, fontSize: 12)),
        ])),
        OutlinedButton(
          onPressed: title.startsWith('Prescription')
              ? () => context.push('/consult-room')
              : null,
          child:
              Text(title.startsWith('Prescription') ? 'Open Chat' : 'Download'),
        ),
      ]),
    );
  }
}
