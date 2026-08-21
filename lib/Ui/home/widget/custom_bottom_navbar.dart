import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_image.dart';

class CustomBottomNavbar extends StatelessWidget {
  final String selectedIcon ;
  final String unselectedIcon ;
  final bool isSelected;
  final VoidCallback onPresses;

  CustomBottomNavbar({super.key,
    required this.onPresses,
    required this.isSelected,
    required this.selectedIcon,
    required this.unselectedIcon});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPresses,
        icon:Image.asset( isSelected ? selectedIcon : unselectedIcon) );


  }
}