import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_config.dart';

class CustomDivider extends StatelessWidget {
  CustomDivider({super.key, required this.endIndent, required this.indent});

  double indent;
  double endIndent;

  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    return Divider(
      color: AppColor.yellowColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
