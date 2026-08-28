import 'package:flutter/material.dart';
import 'package:my_movies_app/Ui/widget/movies_grid/movie_card_image.dart';
import 'package:my_movies_app/api/model/movies/movies.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:my_movies_app/utils/firebase_osama_test.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie});
  final Movies movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //Todo: Go to detailes
        FirebaseOsamaTest.addFaviorate(Favourite(url: movie.url!, rating: movie.rating!, movieId: movie.id!, userId:"118130069047949677371"))
            .then((value) {
              print("Add Success");
        },).catchError((error) {
          print(error);
        },);
        print("Clicked Id :${movie.id}");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            MovieCardImage(url:this.movie.largeCoverImage!,),
            Positioned(
                top: 12,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blackColor.withAlpha(182)
                  ),
              child: Row(
                spacing: 6,
                children: [
                  Text(this.movie.rating.toString(),
                  style: AppStyle.reg14White,),
                  Image.asset(AppImage.starIcon,
                  height: 14,
                      width: 14,),

                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
}
