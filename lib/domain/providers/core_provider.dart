import '../../data/database/query_executor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../presentation/models/bottom_navigation_item.dart';
import '../../presentation/pages/gallery_view/gallery_view_screen.dart';
import '../../presentation/pages/profile/profile_screen.dart';

final providerAppDatabase = Provider<AppDatabase>((ref) {
  throw UnimplementedError();
});

final providerQueryExecutor = Provider<QueryExecutor>((ref) {
  final database = ref.read(providerAppDatabase);
  return QueryExecutor(database);
}, dependencies: [providerAppDatabase]);

final providerBottomTabs = Provider((ref) {
  return [
    BottomNavigationItem(
      icon: Icons.home,
      title: 'Home',
      child: const GalleryViewScreen(),
    ),
    BottomNavigationItem(
      icon: Icons.person,
      title: 'Profile',
      child: const ProfileScreen(),
    )
  ];
});
