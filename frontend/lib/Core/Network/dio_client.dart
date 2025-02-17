import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

Dio createDio({required String baseUrl, bool trustSelfSigned = true}) {
  // initialize dio
  final dio = Dio()..options.baseUrl = baseUrl;

  // allow self-signed certificate
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => trustSelfSigned;
    return client;
  };

  return dio;
}
