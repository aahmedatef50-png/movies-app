import 'package:flutter/material.dart';
import 'package:my_movies_app/ui/widget/custom_text_form_feild.dart';
import 'package:my_movies_app/utils/app_image.dart';

class EditInputs extends StatelessWidget {
  EditInputs({required this.nameController,required this.phoneController});
  TextEditingController nameController;
  TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return             Column(
      spacing: 20,
      children: [
        CustomTextFormFeild(hintText: "",
          controller: nameController,
          textInputType: TextInputType.name,
          prefixIcon:Image(image: AssetImage(AppImage.userIcon),) ,),
        CustomTextFormFeild(hintText: "",
          controller: phoneController,
          textInputType: TextInputType.phone,
          prefixIcon:Image(image: AssetImage(AppImage.phoneIcon),) ,)
      ],
    );
  }
}
