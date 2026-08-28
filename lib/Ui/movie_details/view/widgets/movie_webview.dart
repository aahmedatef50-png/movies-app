import 'package:flutter/material.dart';
import 'package:my_movies_app/api/model/movies_details/movie.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MovieWebview extends StatefulWidget {
  final Movie movie;

  const MovieWebview({
    // super.key,
    required this.movie,
  });

  @override
  State<MovieWebview> createState() => _MovieWebviewState();
}

class _MovieWebviewState extends State<MovieWebview> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.movie.url ?? ''),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}