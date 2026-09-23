import 'package:flutter/material.dart';
import '../core/constants.dart';

class BannerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? image;
  const BannerCard(
      {super.key, required this.title, required this.subtitle, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFF7FB), Color(0xFFBFEAF2)],
          ),
        ),
        child: Stack(
          children: [
            if (image != null)
              Positioned.fill(
                child: Image.asset(image!, fit: BoxFit.cover),
              ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: .90),
                      Colors.white.withValues(alpha: .08)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final contentWidth = constraints.maxWidth < 245
                        ? constraints.maxWidth
                        : 245.0;
                    return SizedBox(
                      width: contentWidth,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 7),
                            Text(subtitle,
                                style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppConstants.primary,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: const Text('Explore now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
