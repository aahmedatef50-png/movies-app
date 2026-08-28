import 'package:flutter/material.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  final String trailerCode;

  const TrailerScreen({
    super.key,
    required this.trailerCode,
  });

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late final YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.trailerCode,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon( Icons.arrow_back_ios_new_rounded,color: AppColor.whiteColor,)),
        title:  Text('Trailer',style: AppStyle.bold24White,),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}