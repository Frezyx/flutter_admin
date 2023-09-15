import 'package:dio/dio.dart';
import 'package:flutter_admin/src/features/network/controller/network_controller.dart';

class DioAnalyserInterceptor extends Interceptor {
  DioAnalyserInterceptor({
    required NetworkController networkController,
  }) : _networkController = networkController;

  final NetworkController _networkController;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    _networkController.sentBytes += options.data?.length ?? 0;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    _networkController.receivedBytes += response.data.toString().length;
  }
}
