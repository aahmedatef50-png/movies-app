import 'package:flutter/material.dart';
import 'package:my_movies_app/model/app_model.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/avatar_grid.dart';

class EditProfileImageButton extends StatelessWidget {
  EditProfileImageButton({required this.profileIndex ,required this.onAvatarChanged});
  int profileIndex;
  final ValueChanged<int> onAvatarChanged;
  @override
  Widget build(BuildContext context) {
    return             Center(
      child: InkWell(
        onTap:(){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(

                color: Colors.grey,
                child:AvatarGrid(activeIndex: profileIndex,onAvatarChanged:onAvatarChanged),
              );
            },
          );
        },
        child: Image(image: AssetImage(AppModel.avatars[profileIndex]),
          width: 150,
          height: 150,
          fit: BoxFit.cover,),
      ),
    );
  }
}
