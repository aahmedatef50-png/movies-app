import 'package:flutter/material.dart';
import 'package:my_movies_app/model/app_model.dart';
import 'package:my_movies_app/utils/app_color.dart';

class AvatarGrid extends StatelessWidget {
  AvatarGrid({required this.activeIndex,required this.onAvatarChanged});
  int activeIndex;
  final ValueChanged<int> onAvatarChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.darkGreyColor,
      child: GridView.builder(
        shrinkWrap: true,
          itemCount: AppModel.avatars.length,
          padding: EdgeInsets.all(20),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing:20,crossAxisSpacing: 20 ),
          itemBuilder:(context,index){
          print(AppModel.avatars[index]);
            return InkWell(onTap: (){
              onAvatarChanged(index);
              Navigator.pop(context);
            },child:Container(
                decoration: BoxDecoration(
                  color: activeIndex==index?AppColor.yellowColor.withAlpha(56):AppColor.transparentColor,
                  border: Border.all(
                    color: AppColor.yellowColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15), // optional, for rounded corners
                ),
                child: Image(image: AssetImage(AppModel.avatars[index]))) ,);
          }),
    );
  }
}
