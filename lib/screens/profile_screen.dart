import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _Page(
      title: 'My Profile',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFE7FAFC), Color(0xFFF7FFFF)]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(children: [
              const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      size: 46, color: AppConstants.tealDark)),
              const SizedBox(width: 14),
              const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Disha Sankneniwar',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20)),
                    SizedBox(height: 5),
                    Text('+91 98224 28103',
                        style: TextStyle(color: AppConstants.muted)),
                  ])),
              OutlinedButton(
                  onPressed: () =>
                      showComingSoonDialog(context, 'Profile editing'),
                  child: const Text('Edit')),
            ]),
          ),
          const SizedBox(height: 22),
          _infoCard('Personal information', [
            ('Date of birth', '27 Dec 2003'),
            ('Gender', 'Female'),
            ('City', 'Pune'),
          ]),
        ],
      ),
    );
  }

  Widget _infoCard(String title, List<(String, String)> rows) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4ECEF)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        ...rows.map((r) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(children: [
                Expanded(
                    child: Text(r.$1,
                        style: const TextStyle(color: AppConstants.muted))),
                Text(r.$2, style: const TextStyle(fontWeight: FontWeight.w700)),
              ]),
            )),
      ]),
    );
  }
}

class _Page extends StatelessWidget {
  final String title;
  final Widget child;
  const _Page({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SafeArea(
          child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: child,
        ),
      )),
    );
  }
}
