import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';
import 'button_scale.dart';

class DoctorCard extends StatelessWidget {
  final DoctorData doctor;
  final VoidCallback? onConsult;
  const DoctorCard({super.key, required this.doctor, this.onConsult});

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2EAED)),
          boxShadow: const [
            BoxShadow(
                color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8))
          ],
        ),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, c) {
                final imageSize = c.maxWidth < 500 ? 120.0 : 140.0;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: doctor.asset.startsWith('http')
                              ? Image.network(
                                  doctor.asset,
                                  width: imageSize,
                                  height: imageSize,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _fallbackImage(imageSize),
                                )
                              : Image.asset(
                                  doctor.asset,
                                  width: imageSize,
                                  height: imageSize,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _fallbackImage(imageSize),
                                ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppConstants.teal,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text('${doctor.experience} years exp',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(doctor.hospital,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                          color: AppConstants.tealDark)),
                                ),
                                Text(doctor.city,
                                    style: const TextStyle(
                                        color: AppConstants.muted,
                                        fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 9),
                            Text(doctor.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 4),
                            Text(doctor.qualification,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppConstants.muted, fontSize: 14)),
                            const SizedBox(height: 5),
                            Text(doctor.specialty,
                                style: const TextStyle(fontSize: 14.5)),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                const Icon(Icons.chat_bubble_outline,
                                    color: AppConstants.teal, size: 20),
                                const SizedBox(width: 6),
                                Expanded(
                                    child: Text(doctor.languages,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded,
                                    color: Color(0xFFFFB300), size: 20),
                                const SizedBox(width: 4),
                                Text(doctor.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                const Spacer(),
                                Text('₹${doctor.fee}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        showComingSoonDialog(context, 'Doctor profile details'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppConstants.tealDark,
                      side: const BorderSide(color: Color(0xFFE8EEF0)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Know More',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: onConsult,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppConstants.coral,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Consult Now',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackImage(double size) => Container(
        width: size,
        height: size,
        color: const Color(0xFFE8F6F8),
        child: const Icon(Icons.person, size: 60, color: AppConstants.tealDark),
      );
}
