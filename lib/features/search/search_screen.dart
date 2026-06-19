// lib/features/search/search_screen.dart

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../shared/widgets/entity_badge.dart';
import 'search_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _query = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = Theme.of(context).colorScheme.surface;
    
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          _buildSearchBar(isDark),
          Expanded(
            child: _buildBody(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    final fill = isDark ? QkaTheme.neutral800 : QkaTheme.neutral100;
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 8),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        style: TextStyle(
          fontFamily: 'SF Pro',
          color: isDark ? QkaTheme.neutral100 : QkaTheme.neutral800,
        ),
        decoration: InputDecoration(
          hintText: 'Search surahs, figures...',
          hintStyle: const TextStyle(
            fontFamily: 'SF Pro',
            color: QkaTheme.neutral400,
          ),
          prefixIcon: const Icon(Icons.search, color: QkaTheme.neutral400),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.clear, color: QkaTheme.neutral400),
                onPressed: () {
                  _controller.clear();
                  _onSearchChanged('');
                },
              );
            },
          ),
          filled: true,
          fillColor: fill,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: QkaTheme.teal400, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_query.trim().isEmpty) {
      return const Center(
        child: Text(
          'Search surahs, figures, locations, and collections',
          style: TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 16,
            color: QkaTheme.neutral400,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    final resultsAsync = ref.watch(searchQueryProvider(_query));

    return resultsAsync.when(
      data: (results) {
        if (results.isEmpty) {
          return Center(
            child: Text(
              'No results for "$_query"',
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 16,
                color: QkaTheme.neutral400,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 24, top: 8),
          children: [
            if (results.surahs.isNotEmpty)
              _buildSectionHeader('Surahs'),
            for (final surah in results.surahs)
              _buildSurahRow(surah, isDark),
              
            if (results.entities.isNotEmpty)
              _buildSectionHeader('Figures & Places'),
            for (final entity in results.entities)
              _buildEntityRow(entity, isDark),
              
            if (results.collections.isNotEmpty)
              _buildSectionHeader('Collections'),
            for (final coll in results.collections)
              _buildCollectionRow(coll, isDark),
          ],
        );
      },
      loading: () => const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: QkaTheme.teal400,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'SF Pro',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: QkaTheme.neutral400,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSurahRow(SearchResultSurah result, bool isDark) {
    final s = result.surah;
    final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;
    final arabicColor = isDark ? QkaTheme.neutral400 : QkaTheme.neutral600;

    return InkWell(
      onTap: () => context.push('/reader/${s.number}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: QkaTheme.teal400.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${s.number}',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: QkaTheme.teal400,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.transliteration,
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: nameColor,
                    ),
                  ),
                  Text(
                    '${s.totalAyahs} ayahs',
                    style: const TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12,
                      color: QkaTheme.neutral400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              s.arabicName,
              style: TextStyle(
                fontFamily: 'Amiri Quran',
                fontSize: 16,
                color: arabicColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityRow(SearchResultEntity result, bool isDark) {
    final e = result.entity;
    final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;
    
    return InkWell(
      onTap: () {
        if (e.isDiscovered) {
          context.push('/encyclopedia/${e.id}');
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Read more of the Quran to unlock this entity.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (e.isDiscovered)
              EntityBadge(entityType: e.type, size: BadgeSize.sm, isDiscovered: true)
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDark ? QkaTheme.neutral800 : QkaTheme.neutral200,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.lock_outline, size: 14, color: QkaTheme.neutral400),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (e.isDiscovered)
                    Text(
                      e.name,
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: nameColor,
                      ),
                    )
                  else
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Text(
                          e.name,
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: nameColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  Text(
                    e.type.replaceAll('_', ' '),
                    style: const TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 12,
                      color: QkaTheme.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionRow(SearchResultCollection coll, bool isDark) {
    final nameColor = isDark ? QkaTheme.neutral100 : QkaTheme.neutral800;

    return InkWell(
      onTap: () {
        context.push(
          '/encyclopedia/collection/${coll.id}',
          extra: {'isSet': coll.isSet, 'name': coll.name},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              coll.isSet ? Icons.style_outlined : Icons.folder_outlined,
              color: QkaTheme.teal400,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                coll.name,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: nameColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
