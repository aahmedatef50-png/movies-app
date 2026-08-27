import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../../api/model/movies_details/cast.dart';
import '../../../../utils/size_utils.dart';

class GenresSection extends StatelessWidget {
  Movie movie;
  GenresSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    final List<String> genresList = movie.genres!;
    return Column(
      spacing: height*.02,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.genres,
          style: AppStyle.bold24White,
          textAlign: TextAlign.start,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.5,
          ),
          itemCount: genresList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.darkGreyColor,
              ),
              alignment: Alignment.center,
              child: Text(
                genresList[index],
                style: AppStyle.reg16White,
              ),
            );
          },
        ),
      ],
    );
  }
}
