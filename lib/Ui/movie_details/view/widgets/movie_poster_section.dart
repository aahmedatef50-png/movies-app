import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_movies_app/Ui/movie_details/view/widgets/trailer_screen.dart';
import 'package:my_movies_app/Ui/widget/custom_loading_widget.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/firebase_utils.dart';

import '../../../../utils/app_image.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/size_utils.dart';

class MoviePosterSection extends StatelessWidget {
  Movie movie;
   MoviePosterSection({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: movie.largeCoverImage!,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => CustomLoadingWidget(),

          errorWidget: (context, url, error) => Icon(Icons.error),


        ),

        Positioned.fill(
          child: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColor.blackColor, AppColor.transparentColor],
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
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: width * .08,
                        color: AppColor.whiteColor,
                      ), onPressed: () {
                        Navigator.pop(context);
                    },
                    ),
                    IconButton(
                      onPressed: ()async{
                        //todo: save movie to history
                        Favourite fav=Favourite(rating: movie.rating!,url: movie.largeCoverImage!,movieId: movie.id!,userId: "s");
                        await FirebaseUtils.addFaviorate(fav);
                      },
                      icon: Icon(
                        Icons.bookmark,
                        size: width * .08,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrailerScreen(
                          trailerCode: movie.ytTrailerCode!,
                        ),
                      ),
                    );
                  },
                    child: Image.asset(AppImage.playMovieImage)),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,

                  spacing: height * .01,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Text(
                            movie.title!,
                            style: AppStyle.bold24White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Text(
                         "${ movie.year ?? ''}",
                      style: AppStyle.bold20Grey,
                      textAlign: TextAlign.center,
                    ),
                  ],),

              ],

            ),
          ),
        ),
      ],
    );
  }
}
