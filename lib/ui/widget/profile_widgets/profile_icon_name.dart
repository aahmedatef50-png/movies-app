import 'package:flutter/cupertino.dart';
import 'package:my_movies_app/model/app_model.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';

class ProfileIconName extends StatelessWidget {

  ProfileIconName({required this.iconIndex,required this.name});
  int iconIndex;
  String name;
  @override
  Widget build(BuildContext context) {
    return  Column(
      spacing: 15,
      children: [
        Image(image: AssetImage(AppModel.avatars[iconIndex]),
          width: 110,
          height: 110,

        fit: BoxFit.cover,),
        Text(name,
          style: AppStyle.bold20White,)
      ],
    );
  }
}
