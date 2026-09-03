import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../../../utils/app_config.dart';

class ContainerListViewBrowseTab extends StatelessWidget {
  ContainerListViewBrowseTab({
    super.key,
    required this.genre,
    required this.isSelected,
  });

  String genre;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    var width = AppConfig.width(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.015),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.yellowColor : AppColor.transparentColor,
        border: isSelected
            ? null
            : BoxBorder.all(color: AppColor.yellowColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        genre,
        style: isSelected ? AppStyle.bold20Black : AppStyle.bold20Yellow,
      ),
    );
  }
}
