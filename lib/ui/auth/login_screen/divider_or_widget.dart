import 'package:flutter/cupertino.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_style.dart';
import '../../widget/custom_divider.dart';

class DividerOrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = AppConfig.width(context);
    return Row(
      children: [
        Expanded(
          child: CustomDivider(indent: width * 0.17, endIndent: width * 0.03),
        ),
        Text(AppLocalizations.of(context)!.or, style: AppStyle.reg15Yellow),
        Expanded(
          child: CustomDivider(indent: width * 0.03, endIndent: width * 0.17),
        ),
      ],
    );
  }
}
