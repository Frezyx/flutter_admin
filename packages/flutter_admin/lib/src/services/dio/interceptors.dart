import 'package:dio/dio.dart';
import 'package:flutter_admin/src/features/network/controller/network_controller.dart';

class DioAnalyzerInterceptor extends Interceptor {
  DioAnalyzerInterceptor({
    required NetworkController networkController,
  }) : _networkController = networkController;

  final NetworkController _networkController;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    _networkController.handleRequest(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    _networkController.handleResponse(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    _networkController.handleException(err);
  }
}
