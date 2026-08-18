import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_inputs.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_profile_buttons.dart';
import 'package:my_movies_app/ui/widget/edit_profile_widgets/edit_profile_image_button.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_route.dart';
import 'package:my_movies_app/utils/app_style.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final nameController = TextEditingController(text: "John Safwat");
  final phoneController = TextEditingController(text: "01200000000");
  int profileIndex=1;
  @override
  Widget build(BuildContext context) {
    var height = AppConfig.height(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_profile,style: AppStyle.reg16Yellow,),
        centerTitle: true,
        backgroundColor: AppColor.blackColor,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: AppColor.yellowColor,size: 21,)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 35,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileImageButton(
                profileIndex: profileIndex, onAvatarChanged: (newIndex) {
                setState(() {
                  profileIndex = newIndex;
                });
              },),
              EditInputs(nameController: nameController,
                  phoneController: phoneController),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      AppRoute.forgetPasswordScreen);
                },
                child: Text(AppLocalizations.of(context)!.reset_password,
                  style: AppStyle.reg20White,
                ),
              ),
              SizedBox(height: height * 0.18,),
              EditProfileButtons()
            ],
          ),
        ),
      ),
    );
  }
}
