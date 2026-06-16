// lib/shared/widgets/update_badge.dart

import 'package:flutter/material.dart';

class UpdateBadge extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;

  const UpdateBadge({
    Key? key,
    required this.visible,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      top: visible ? 56.0 : -40.0, // Slides in from -40px to 56px (below status bar)
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: visible ? 1.0 : 0.0,
          child: IgnorePointer(
            ignoring: !visible,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D3A2F), // dark teal surface
                  borderRadius: BorderRadius.circular(999), // radius-full
                  border: Border.all(color: const Color(0xFF1D9E75), width: 1.0), // teal-400
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.refresh,
                      size: 14,
                      color: Color(0xFF5DCAA5), // teal-200
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Tap to update',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5DCAA5), // teal-200
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
