// lib/features/search/search_screen.dart

import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Search Screen - Query Surahs, Characters, and Locations'),
      ),
    );
  }
}
