import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

class CustomTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: AppColor.whiteColor,
      indicator:  UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColor.yellowColor, width: 3),
        insets: EdgeInsets.symmetric(horizontal: 20),
      ),
      unselectedLabelColor: Colors.white,
      indicatorColor: AppColor.yellowColor,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelStyle: AppStyle.bold20White,
      unselectedLabelStyle: AppStyle.bold20White,
      tabs: [
        Tab(
          icon: Icon(Icons.list,color: AppColor.yellowColor,size: 32,),
          text: AppLocalizations.of(context)!.watch_list,
        ),
        Tab(
          icon: Icon(Icons.folder,color: AppColor.yellowColor,size: 32,),
          text: AppLocalizations.of(context)!.history,

        ),
      ],
    );
  }
}
