// lib/shared/widgets/constellation_side_panel.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../features/encyclopedia/encyclopedia_notifier.dart';
import 'entity_badge.dart';

class ConstellationSidePanel extends ConsumerWidget {
  final String? entityId;
  final bool visible;
  final VoidCallback onClose;

  const ConstellationSidePanel({
    Key? key,
    required this.entityId,
    required this.visible,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      top: 0,
      bottom: 0,
      right: visible ? 0.0 : -260.0, // Slides in from right
      width: 260.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F2030), // slightly lighter navy
          border: Border(
            left: BorderSide(color: Color(0xFF1D3A2F), width: 1.0),
          ),
        ),
        child: SafeArea(
          child: entityId == null
              ? const SizedBox.shrink()
              : _buildContent(context, ref, entityId!),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, String id) {
    final detailAsync = ref.watch(entityDetailProvider(id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button at top-right
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              onPressed: onClose,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          const SizedBox(height: 12),

          detailAsync.when(
            data: (detail) {
              final entity = detail.entity;
              
              // Find first trigger reference
              final firstTrigger = detail.triggers.isNotEmpty
                  ? detail.triggers.first
                  : null;

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EntityBadge
                    EntityBadge(
                      entityType: entity.type,
                      size: BadgeSize.md,
                      isDiscovered: true,
                    ),
                    const SizedBox(height: 16),

                    // Entity Name
                    Text(
                      entity.name,
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Type label
                    Text(
                      _formatType(entity.type),
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        color: Color(0xFF5DCAA5), // teal-200
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Divider(color: Color(0xFF1D3A2F), thickness: 1.0, height: 1),
                    const SizedBox(height: 20),

                    // Discovered in
                    if (firstTrigger != null) ...[
                      const Text(
                        'Discovered in',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 11,
                          color: QkaTheme.neutral400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: () {
                          context.push(
                            '/reader/${firstTrigger.trigger.surahNum}',
                            extra: {'startAyah': firstTrigger.trigger.ayahNum},
                          );
                        },
                        child: Text(
                          'Surah ${firstTrigger.trigger.surahNum}, Ayah ${firstTrigger.trigger.ayahNum}',
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 12,
                            color: Color(0xFF5DCAA5), // teal-200
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFF1D3A2F), thickness: 1.0, height: 1),
                      const SizedBox(height: 20),
                    ],

                    // Connected to
                    const Text(
                      'Connected to',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 11,
                        color: QkaTheme.neutral400,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${detail.connectedEntities.length} connection${detail.connectedEntities.length == 1 ? "" : "s"}',
                      style: const TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),

                    const Spacer(),

                    // View in encyclopedia
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.push('/encyclopedia/$id');
                        },
                        child: const Text(
                          'View in encyclopedia →',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 13,
                            color: Color(0xFF5DCAA5), // teal-200
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF5DCAA5)),
              ),
            ),
            error: (err, stack) => Expanded(
              child: Center(
                child: Text(
                  'Error loading entity: $err',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatType(String rawType) {
    switch (rawType.toLowerCase()) {
      case 'prophet':
        return 'Prophet';
      case 'historical_figure':
        return 'Figure';
      case 'matriarch':
        return 'Matriarch';
      case 'location':
        return 'Location';
      case 'nature':
      case 'animal':
      case 'plant':
        return 'Nature';
      case 'theme':
        return 'Theme';
      default:
        return rawType;
    }
  }
}
