import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkController extends ChangeNotifier {
  num _sentBytes = 0;
  num _receivedBytes = 0;

  num get sentBytes => _sentBytes;
  num get receivedBytes => _receivedBytes;

  void handleRequest(RequestOptions options) {
    _sentBytes += options.data?.length ?? 0;
    _requestsOrder.add(options);
    notifyListeners();
  }

  void handleResponse(Response<dynamic> response) {
    _receivedBytes += response.data.toString().length;
    final requestUrl = response.requestOptions.uri;
    final index = _getFirstRequestIndex(requestUrl);
    if (index >= 0) {
      final options = _requestsOrder[index];
      _responses.addAll({options: response});
      _removeRequest(index);
    }
    notifyListeners();
  }

  void handleException(DioException err) {
    final requestUrl = err.requestOptions.uri;
    final index = _getFirstRequestIndex(requestUrl);
    if (index >= 0) {
      final options = _requestsOrder[index];
      _exceptions.addAll({options: err});
      _removeRequest(index);
    }
    notifyListeners();
  }

  void _removeRequest(int requestIndex) {
    _requestsOrder.removeAt(requestIndex);
  }

  int _getFirstRequestIndex(Uri requestUrl) {
    final requestIndex = _requestsOrder.indexWhere((e) => e.uri == requestUrl);
    return requestIndex;
  }

  final _requestsOrder = <RequestOptions>[];

  Map<RequestOptions, Response<dynamic>> get responses => _responses;
  final _responses = <RequestOptions, Response<dynamic>>{};

  final _exceptions = <RequestOptions, DioException>{};
}
