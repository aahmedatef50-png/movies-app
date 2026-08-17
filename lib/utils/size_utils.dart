import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';

class AppConfig {
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

extension ScreenUtils on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
