import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About mfine')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: const Color(0xFFEAF8FC), borderRadius: BorderRadius.circular(22)),
            child: const Column(children: [
              CircleAvatar(radius: 40, backgroundColor: Color(0xFF00A6BC), child: Icon(Icons.monitor_heart_rounded, color: Colors.white, size: 48)),
              SizedBox(height: 12),
              Text('mfine', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Color(0xFF008EA0))),
              SizedBox(height: 5),
              Text('Care that comes to you', style: TextStyle(color: Color(0xFF6B737B))),
            ]),
          ),
          const SizedBox(height: 18),
          const ListTile(title: Text('App version'), trailing: Text('1.0.0')),
          const Divider(),
          const ListTile(title: Text('Privacy Policy'), trailing: Icon(Icons.chevron_right)),
          const ListTile(title: Text('Terms and Conditions'), trailing: Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
