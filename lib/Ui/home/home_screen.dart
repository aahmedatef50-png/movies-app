import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/home/tabs/browser_tab.dart';
import 'package:my_movies_app/Ui/home/tabs/home_tab.dart';
import 'package:my_movies_app/Ui/home/tabs/search_tab.dart';
import 'package:my_movies_app/ui/profile/profile.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_image.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;

  List<Widget> tabsList = [
    HomeTab(),
    SearchTab(),
    BrowserTab(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    var height = AppConfig.height(context);
    return Scaffold(
      body: tabsList[selectedIndex] ,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.04
        ),
        child: ClipRRect(

          borderRadius: BorderRadius.circular(16),

          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: AppColor.darkGreyColor),
            child: BottomNavigationBar(

              selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,

                currentIndex: selectedIndex,
                onTap: (index){
                selectedIndex=index;
                setState(() {

                });
                },
                items: [
                  _builtbottomNavigationBarItem(
                      selectedIcon: Image.asset(AppImage.homeSelectedIcon),
                      unselectedIcon: Image.asset(AppImage.homeIcon),
                      isSelected: selectedIndex==0,),
                  _builtbottomNavigationBarItem(
                      selectedIcon: Image.asset(AppImage.searchSelectedIcon),
                      unselectedIcon: Image.asset(AppImage.searchIcon),
                      isSelected: selectedIndex==1),
                  _builtbottomNavigationBarItem(
                      selectedIcon: Image.asset(AppImage.browseSelectedIcon),
                      unselectedIcon: Image.asset(AppImage.browseIcon),
                      isSelected: selectedIndex==2),
                  _builtbottomNavigationBarItem(
                      selectedIcon: Image.asset(AppImage.profileSelectedIcon),
                      unselectedIcon: Image.asset(AppImage.profileIcon),
                      isSelected: selectedIndex==3),
            ]),
          ),
        ),
      ),
    );
  }

   BottomNavigationBarItem _builtbottomNavigationBarItem({
     required Widget selectedIcon,
     required Widget unselectedIcon,

     required bool isSelected,
   }) {
     return BottomNavigationBarItem(
       icon: isSelected ? selectedIcon : unselectedIcon,
       label: ''

     );
   }

}
