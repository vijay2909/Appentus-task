import 'package:flutter/cupertino.dart';

class BottomNavigationItem {
  final IconData icon;
  final String title;
  final Widget child;

  BottomNavigationItem({
    required this.icon,
    required this.title,
    required this.child,
  });
}
