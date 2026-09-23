import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 96, width: 96,
              decoration: BoxDecoration(
                color: AppConstants.teal,
                borderRadius: BorderRadius.circular(26),
                boxShadow: const [BoxShadow(color: Color(0x3300A6BC), blurRadius: 28, offset: Offset(0, 14))],
              ),
              child: const Icon(Icons.monitor_heart_rounded, color: Colors.white, size: 55),
            ),
            const SizedBox(height: 16),
            const Text('mfine', style: TextStyle(color: AppConstants.tealDark, fontWeight: FontWeight.w900, fontSize: 34)),
            const SizedBox(height: 5),
            const Text('Care that comes to you', style: TextStyle(color: AppConstants.muted)),
          ]),
        ),
      ),
    );
  }
}
