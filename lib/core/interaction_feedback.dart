import 'package:flutter/material.dart';

import 'constants.dart';

void showMfineToast(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 88),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isError ? const Color(0xFFFFD1C7) : const Color(0xFFC7EEF3),
          ),
        ),
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle,
              color: isError ? AppConstants.coral : AppConstants.teal,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: AppConstants.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
}

Future<void> showComingSoonDialog(BuildContext context, String feature) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Coming soon'),
      content: Text('$feature is being uner enhanchmnet.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Got it'),
        ),
      ],
    ),
  );
}

Future<void> showNetworkErrorDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      icon: const Icon(Icons.cloud_off_rounded, size: 38),
      title: const Text('Network error'),
      content:
          const Text('We could not connect to this consultation right now.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Try again'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text('Go home'),
        ),
      ],
    ),
  );
}
