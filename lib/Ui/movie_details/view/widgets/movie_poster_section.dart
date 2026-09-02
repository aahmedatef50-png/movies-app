import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/trailer_screen.dart';
import 'package:my_movies_app/Ui/widget/custom_loading_widget.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';
import 'package:my_movies_app/utils/utils_dialog.dart';

import '../../../../utils/app_image.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/size_utils.dart';

class MoviePosterSection extends StatefulWidget {
  final Movie movie;
  final String userId;

  const MoviePosterSection({
    super.key,
    required this.movie,
    required this.userId,
  });

  @override
  State<MoviePosterSection> createState() => _MoviePosterSectionState();
}

class _MoviePosterSectionState extends State<MoviePosterSection> {
  bool isFavorite = false;
  bool isLoadingFavorite = true;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    final result = await FirebaseUtils.isFavorite(
      widget.userId,
      widget.movie.id!,
    );

    if (mounted) {
      setState(() {
        isFavorite = result;
        isLoadingFavorite = false;
      });
    }
  }
  Future<void> toggleFavorite() async {
    try {
      // Show loading
      UtilsDialog.showLoading(
        context: context,
        content: "Please wait...",
      );

      if (isFavorite) {
        await FirebaseUtils.removeFavorite(
          widget.userId,
          widget.movie.id!,
        );

        if (!mounted) return;

        // Hide loading
        UtilsDialog.hideDialog(context: context);

        setState(() {
          isFavorite = false;
        });

        UtilsDialog.showMessage(
          context: context,
          title: "Success",
          content: "Movie removed from favorites",
          posAction: "OK",
        );
      } else {
        final fav = Favourite(
          rating: widget.movie.rating!,
          largeCoverImage: widget.movie.largeCoverImage!,
          movieId: widget.movie.id!,
          userId: widget.userId,
        );

        await FirebaseUtils.addFavorite(fav);

        if (!mounted) return;

        // Hide loading
        UtilsDialog.hideDialog(context: context);

        setState(() {
          isFavorite = true;
        });

        UtilsDialog.showMessage(
          context: context,
          title: "Success",
          content: "Movie added to favorites",
          posAction: "OK",
        );
      }
    } catch (e) {
      if (!mounted) return;

      // Hide loading
      Navigator.of(context).pop();

      UtilsDialog.showMessage(
        context: context,
        title: "Error",
        content: "Something went wrong",
        posAction: "OK",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.movie.largeCoverImage!,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => CustomLoadingWidget(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColor.blackColor,
                  AppColor.transparentColor,
                ],
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: width * .08,
                        color: AppColor.whiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    IconButton(
                      onPressed: isLoadingFavorite
                          ? null
                          : toggleFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        size: width * .08,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrailerScreen(
                          trailerCode: widget.movie.ytTrailerCode!,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(AppImage.playMovieImage),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: height * .01,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.movie.title!,
                            style: AppStyle.bold24White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.movie.year ?? ''}",
                      style: AppStyle.bold20Grey,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}