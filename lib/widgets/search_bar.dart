import 'package:flutter/material.dart';

class MFineSearchBar extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  const MFineSearchBar(
      {super.key, this.hint = 'Search services, programs, labs', this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE8EEF0)),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 16,
                  offset: Offset(0, 6))
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFFAFB7BB), size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Text(hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xFF8D979B), fontSize: 16)),
              ),
              const Icon(Icons.mic_none_rounded, color: Color(0xFFB7C0C4)),
            ],
          ),
        ),
      ),
    );
  }
}
