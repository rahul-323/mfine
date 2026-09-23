import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/interaction_feedback.dart';

class LabTestCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final int price;
  final int oldPrice;
  final String discount;
  const LabTestCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4ECEF)),
        boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 16, offset: Offset(0, 7))],
      ),
      child: Row(
        children: [
          Container(
            width: 58, height: 58,
            decoration: BoxDecoration(color: const Color(0xFFEAF9FA), borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.biotech_rounded, color: AppConstants.tealDark, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(name, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE3F7E9), borderRadius: BorderRadius.circular(7)),
                  child: Text(discount, style: const TextStyle(color: Color(0xFF238343), fontSize: 11, fontWeight: FontWeight.w800)),
                ),
              ]),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: AppConstants.muted, fontSize: 12.5)),
              const SizedBox(height: 8),
              Row(children: [
                Text('₹$price', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                const SizedBox(width: 8),
                Text('₹$oldPrice', style: const TextStyle(decoration: TextDecoration.lineThrough, color: AppConstants.muted)),
                const Spacer(),
                FilledButton(
                  onPressed: () => showComingSoonDialog(context, 'Lab booking'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppConstants.coral,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  child: const Text('Book'),
                ),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}
