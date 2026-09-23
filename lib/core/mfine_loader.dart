import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';

Future<T?> runWithMfineLoader<T>(
  BuildContext context,
  Future<T> Function() action, {
  String message = 'Preparing your mfine experience...',
}) async {
  final minimumDelay = Duration(seconds: 2 + Random().nextInt(5));

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black38,
    builder: (_) => PopScope(
      canPop: false,
      child: Center(
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 46,
                  width: 46,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation(AppConstants.teal),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'mfine',
                  style: TextStyle(
                    color: AppConstants.tealDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppConstants.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  try {
    final result = await Future.wait<Object?>([
      action(),
      Future<void>.delayed(minimumDelay),
    ]);
    return result.first as T?;
  } finally {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
