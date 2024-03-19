import 'package:dio/dio.dart';

String getMessageFromError(DioError error) {
  String message = "Something went wrong";
  final data = error.response?.data;
  if (data != null && data is Map && data.containsKey('message')) {
    message = data['message'];
  }

  return message;
}
