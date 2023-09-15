import 'package:dio/dio.dart';

class DioAnalyserInterceptor extends Interceptor {
  DioAnalyserInterceptor();

  num sentBytes = 0;
  num receivedBytes = 0;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    sentBytes += options.data?.length ?? 0;
    print('SentBytes: $sentBytes');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    receivedBytes += response.data.toString().length;
    print('ReceivedBytes $receivedBytes');
  }
}
