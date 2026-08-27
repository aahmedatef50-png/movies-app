import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/size_utils.dart';

import '../../../../api/model/movies_details/movie.dart';

class ScreenshotsSection extends StatelessWidget {
  final Movie movie;

  ScreenshotsSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    final thumbnails = [
      movie.mediumScreenshotImage1,
      movie.mediumScreenshotImage2,
      movie.mediumScreenshotImage3,
    ].whereType<String>().toList();

    return Column(
      spacing: context.height * .02,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.screen_shots,
          style: AppStyle.bold24White,
          textAlign: TextAlign.start,
        ),
        ...thumbnails.map((imageUrl) {
          return Padding(
            padding: EdgeInsets.only(bottom: height * .005),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: height * .2,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
