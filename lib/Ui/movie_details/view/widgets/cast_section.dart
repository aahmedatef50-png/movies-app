import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../../api/model/movies_details/cast.dart';
import '../../../../utils/size_utils.dart';

class CastSection extends StatelessWidget {
  Movie movie;
  CastSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    final List<Cast> castList = movie.cast!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.cast,
          style: AppStyle.bold24White,
          textAlign: TextAlign.start,
        ),
        ...castList.map((cast) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: height * .01),
            padding: EdgeInsets.symmetric(
              vertical: height * .01,
              horizontal: width * .03,
            ),
            decoration: BoxDecoration(
              color: AppColor.darkGreyColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              spacing: width * .03,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),

                  child: Image.network(
                    cast.urlSmallImage??"https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",                    fit: BoxFit.fill,
                    height: height * .1,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.name}:${cast.name!}",
                        style: AppStyle.reg20White,
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.character}:${cast.characterName!}",
                        style: AppStyle.reg20White,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ListTile(
            //
            //   leading: ClipRRect(borderRadius: BorderRadius.circular(8),
            //       child: Image.network(cast.urlSmallImage!, fit: BoxFit.fill,height: height*.1,)),
            //   title: Text("${AppLocalizations.of(context)!.name}:${cast.name!}",style: AppStyle.reg20White,),
            //   subtitle: Text("${AppLocalizations.of(context)!.character}:${cast.characterName!}",style: AppStyle.reg20White,),
            // ),
          );
        }),
      ],
    );
  }
}
