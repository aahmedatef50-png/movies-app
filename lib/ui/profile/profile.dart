import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/cubit/my_user_cubit.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/ui/widget/profile_widgets/custom_count_label.dart';
import 'package:my_movies_app/ui/widget/profile_widgets/custom_tabBar.dart';
import 'package:my_movies_app/ui/widget/profile_widgets/custom_tabbar_view.dart';
import 'package:my_movies_app/ui/widget/profile_widgets/profile_icon_name.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    final myUser = context
        .watch<MyUserCubit>()
        .state;
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        body:SafeArea(
          child: Column(
            children: [
              Container(
                color: AppColor.darkGreyColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 0),
                  child: Column(
                    spacing: 20,
                    children: [
                      Row(
                        spacing: width * 0.07,
                        children: [
                          Expanded(
                              child: ProfileIconName(name: myUser.name,
                                iconIndex: myUser.imageIndex,)),
                          CustomCountlabel(
                            label: AppLocalizations.of(context)!.wish_list,
                            count: 100,),
                          CustomCountlabel(
                            label: AppLocalizations.of(context)!.history,
                            count: 10,),

                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [

                          Expanded(
                            flex: 4,
                            child: CustomElevatedButton(
                              onTap: (){
                                Navigator.of(context).pushNamed(AppRoute.editProfileScreen);

                              },
                              child: Text(AppLocalizations.of(context)!.edit_profile,
                              style: AppStyle.reg20DarkGrey,),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context, AppRoute.loginScreen, (
                                    route) => false,);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Text(AppLocalizations.of(context)!.exit,style: AppStyle.reg20White,),
                                  Image(image: AssetImage(AppImage.exitIcon),)
                                ],
                              ),
                              backgroundColor: AppColor.redColor,
                            ),
                          )
                        ],
                      ),
                      CustomTabBar(),

                    ],
                  ),
                ),
              ),
              Expanded(child: CustomTabBarView())
            ],
          ),
        ),
      ),
    );
  }
}
