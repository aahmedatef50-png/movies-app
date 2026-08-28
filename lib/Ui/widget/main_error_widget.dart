import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;

  MainErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.height * 0.02,
          children: [
            Text(
              errorMessage, style: AppStyle.bold20White,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Try Again', style: AppStyle.bold20Yellow),
            ),
          ],
        ),
      ),
    );
  }
}