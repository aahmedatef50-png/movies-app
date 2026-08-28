import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/model/app_model.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/avatar_grid.dart';

import '../../../cubit/my_user_cubit.dart';

class EditProfileImageButton extends StatelessWidget {
  EditProfileImageButton({required this.profileIndex ,required this.onAvatarChanged});
  int profileIndex;
  final ValueChanged<int> onAvatarChanged;
  @override
  Widget build(BuildContext context) {
    var myUser = context
        .read<MyUserCubit>()
        .state;

    return             Center(
      child: InkWell(
        onTap:(){
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(

                color: Colors.grey,
                child: AvatarGrid(activeIndex: myUser.imageIndex,
                    onAvatarChanged: onAvatarChanged),
              );
            },
          );
        },
        child: Image(image: AssetImage(AppModel.avatars[myUser.imageIndex]),
          width: 150,
          height: 150,
          fit: BoxFit.cover,),
      ),
    );
  }
}
