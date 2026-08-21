import 'package:flutter/cupertino.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/ui/widget/custom_elevated_button.dart';
import 'package:my_movies_app/utils/app_config.dart';
import 'package:my_movies_app/utils/app_style.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({super.key, required this.text, required this.onClick});

  VoidCallback onClick;
  String text;

  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            Text(text, style: AppStyle.bold24White),
            CustomElevatedButton(
              onTap: onClick,
              child: Text(
                AppLocalizations.of(context)!.try_again,
                style: AppStyle.bold20Black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
