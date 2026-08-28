import 'package:flutter/material.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

class EditProfileButtons extends StatelessWidget {
  VoidCallback onclick;
  VoidCallback onDelete;

  EditProfileButtons({required this.onclick, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return             Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        CustomElevatedButton(
          child: Text(AppLocalizations.of(context)!.delete_account,
            style: AppStyle.reg20White,
          ),
          onTap: onDelete,

          backgroundColor: AppColor.redColor,
        ),
        CustomElevatedButton(
            child: Text(AppLocalizations.of(context)!.update_data,
              style: AppStyle.reg20DarkGrey,
            ),
            onTap: onclick
        ),
      ],
    );
  }
}
