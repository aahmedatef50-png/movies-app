import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/home/tabs/search_tab.dart';
import 'package:my_movies_app/Ui/home/widget/custom_bottom_navbar.dart';
import 'package:my_movies_app/Ui/profile/profile.dart';
import 'package:my_movies_app/ui/home/tabs/browser_tab.dart';
import 'package:my_movies_app/ui/home/tabs/home_tab.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_image.dart';

import '../../cubit/genre_index_cubit.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);
    return Scaffold(
        body:Stack(

          children: [
            IndexedStack(
              index: currentIndex,
              children: [
                HomeTab(isActive: currentIndex == 0,
                  seeMoreClick: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                  ,),
                SearchTab(),
                BrowserTab(),
                Profile()
              ],
            ),
            Positioned(
                left: width*0.05,
                right: width*0.05,
                bottom:40 ,
                child:Container(
                  height: height*0.06,

                  decoration: BoxDecoration(
                    color: AppColor.darkGreyColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBottomNavbar(onPresses: (){
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                          isSelected: currentIndex==0,
                          selectedIcon: AppImage.homeSelectedIcon,
                          unselectedIcon: AppImage.homeIcon),
                      CustomBottomNavbar(onPresses: (){
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                          isSelected: currentIndex==1,
                          selectedIcon: AppImage.searchSelectedIcon,
                          unselectedIcon: AppImage.searchIcon),
                      CustomBottomNavbar(onPresses: (){
                        setState(() {
                          context.read<GenreIndexCubit>().resetIndex();
                          currentIndex = 2;
                        });
                      },
                          isSelected: currentIndex==2,
                          selectedIcon: AppImage.browseSelectedIcon,
                          unselectedIcon: AppImage.browseIcon),

                      CustomBottomNavbar(onPresses: (){
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                          isSelected: currentIndex==3,
                          selectedIcon: AppImage.profileSelectedIcon,
                          unselectedIcon: AppImage.profileIcon),



                    ],
                  ),
                ))
          ],
        ));
  }

}