import 'dart:core';
import 'package:dio/dio.dart';

import '../../../config/app_config.dart';
import 'exceptions.dart';

/// Expose a HTTP client without actually exposing that we're using [Dio]
/// underneath.
class HttpClient {
  late final Dio _client;
  String? session;

  HttpClient(AppConfig config) {
    _client = Dio(
      BaseOptions(
        baseUrl: 'https://${config.endpointOrigin}',
        connectTimeout: 5000,
        receiveTimeout: 5000,
      ),
    );

    _client.interceptors.add(
      InterceptorsWrapper(onRequest: handleAddAuthorizationToken),
    );

    //TODO: add interceptor to logout on error 403
  }

  void handleAddAuthorizationToken(request, handler) {
    if (session?.isNotEmpty == true) {
      request.headers['Authorization'] = 'Bearer $session';
    }

    handler.next(request);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _client.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _client.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }
}
