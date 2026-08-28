import 'package:flutter/cupertino.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/size_utils.dart';
import 'package:my_movies_app/utils/app_style.dart';


class MovieStateSection extends StatelessWidget {
  String icon;
  String text;
   MovieStateSection({super.key,required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.002),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.darkGreyColor,

      ),
      child: Row(
        spacing: width*.02,
        children: [
          ImageIcon(AssetImage(icon),color: AppColor.yellowColor,),
          Text(text,style: AppStyle.bold24White,)
        ],
      ),
    );
  }
}
