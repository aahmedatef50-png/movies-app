import 'package:dio/dio.dart';
import 'package:my_movies_app/api/api_Exception.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    String? message;
    switch (err.type) {
      case DioExceptionType.cancel:
        message = "The request was cancelled. Please try again.";
        break;
      case DioExceptionType.connectionTimeout:
        message = "The connection is taking too long. Please try again.";
        break;
      case DioExceptionType.unknown:
        message =
            "Something went wrong. Please check your internet connection and try again.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "The server is taking too long to respond. Please try again.";
        break;
      case DioExceptionType.connectionError:
        message =
            "No internet connection. Please check your connection and try again.";
        break;
      case DioExceptionType.badResponse:
        message = "Something went wrong. Please try again later.";
        break;
      case DioExceptionType.sendTimeout:
        message =
            "Something went wrong while loading the data. Please try again.";
        break;
      default:
        message = "Something went wrong";
        break;
    }
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ApiException(message),
        response: err.response,
        type: err.type,
      ),
    );
  }
}
