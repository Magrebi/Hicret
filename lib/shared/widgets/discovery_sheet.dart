// lib/shared/widgets/discovery_sheet.dart

import 'package:flutter/material.dart';
import '../../features/discovery/discovery_result.dart';

/// Bottom sheet widget displayed upon entity discovery.
/// Supports both standard and rare unlocks.
class DiscoverySheet extends StatelessWidget {
  final DiscoveryResult result;
  final bool? forceRare;

  const DiscoverySheet({
    Key? key,
    required this.result,
    this.forceRare,
  }) : super(key: key);

  const DiscoverySheet.standard(
    this.result, {
    Key? key,
  })  : forceRare = false,
        super(key: key);

  const DiscoverySheet.rare(
    this.result, {
    Key? key,
  })  : forceRare = true,
        super(key: key);

  /// Helper utility to display the bottom sheet dynamically based on result contents.
  static Future<void> show(BuildContext context, DiscoveryResult result) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DiscoverySheet(result: result),
    );
  }

  static Future<void> standardSheet(BuildContext context, DiscoveryResult result) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DiscoverySheet.standard(result),
    );
  }

  static Future<void> rareSheet(BuildContext context, DiscoveryResult result) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DiscoverySheet.rare(result),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasRare = forceRare ?? result.hasRareUnlock;

    return hasRare ? _buildRareLayout(context) : _buildStandardLayout(context);
  }

  /// Standard Variant: ~28% height, cream background, lists triggers rows, no wash
  Widget _buildStandardLayout(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: const BoxDecoration(
        color: Color(0xFFFDFCFA), // Warm cream surface bg
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), // radius-lg
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DISCOVERED',
            style: TextStyle(
              color: Color(0xFF1D9E75), // teal-400
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: result.unlocks.length,
              itemBuilder: (context, index) {
                final entity = result.unlocks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      // Geometric polygon representation placeholder
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1D9E75),
                          shape: BoxShape.rectangle, // Polygon represented by custom rounded geometries
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        entity.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        entity.type.toUpperCase(),
                        style: const TextStyle(fontSize: 11, color: Color(0xFF8C8880)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'View in encyclopedia →',
                style: TextStyle(color: Color(0xFF0F6E56), fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Rare Variant: ~45% height, teal wash gradient, centered medallion, display name
  Widget _buildRareLayout(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFB8E8D8), // wash-bg (semi-transparent teal)
            Color(0xFF0F6E56), // solid teal-600 base
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'RARE DISCOVERY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          // Islamic geometric calligraphic medallion (octagonal / multi-pointed vector; no human figure)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.star_half, // Represents the multi-pointed star badge
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            result.unlocks.firstWhere((e) => e.isRare).name,
            style: const TextStyle(
              fontFamily: 'Serif',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '// TODO: Tafsir — content team to supply',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'View in encyclopedia →',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
