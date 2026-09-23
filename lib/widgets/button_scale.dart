import 'package:flutter/material.dart';

class ScaleOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  const ScaleOnTap({super.key, required this.child, this.onTap});

  @override
  State<ScaleOnTap> createState() => _ScaleOnTapState();
}

class _ScaleOnTapState extends State<ScaleOnTap> with SingleTickerProviderStateMixin {
  double _scale = 1;
  void _down(_) => setState(() => _scale = 0.97);
  void _up([_]) => setState(() => _scale = 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down,
      onTapCancel: _up,
      onTapUp: (_) {
        _up();
        widget.onTap?.call();
      },
      child: AnimatedScale(scale: _scale, duration: const Duration(milliseconds: 90), child: widget.child),
    );
  }
}
