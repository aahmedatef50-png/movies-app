import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';

class MovieCardImage extends StatelessWidget {
  const MovieCardImage({required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return  Image.network(url,
      loadingBuilder: (context,child,progress){
        if(progress==null) return child;
        return Container(
          color: AppColor.darkGreyColor,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2,color: AppColor.yellowColor,),
          ),
        );
      },

    );
  }
}