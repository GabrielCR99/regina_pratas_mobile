import 'package:dio/dio.dart';

import '../../../logger/app_logger.dart';

class RestClientLogInterceptor extends Interceptor {
  final AppLogger _logger;
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseBody;
  final bool responseHeader;
  final bool error;

  RestClientLogInterceptor({
    required AppLogger logger,
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  }) : _logger = logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.append('*** Request ***');

    _printKV('uri', options.uri);

    if (request) {
      _printKV('method', options.method);
      _printKV('responseType', options.responseType.toString());
      _printKV(
        'receiveDataWhenStatusError',
        options.receiveDataWhenStatusError,
      );
    }
    if (requestHeader) {
      _logger.append('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v));
    }
    if (requestBody) {
      _logger.append('data:');
      _printAll(options.data);
    }
    _logger.closeAppend();

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.append('*** Response ***');
    _printResponse(response);

    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error) {
      _logger
        ..append('*** DioError ***')
        ..append('uri: ${err.requestOptions.uri}')
        ..append('$err');

      if (err.response != null) {
        _printResponse(err.response!, isError: true);
      }
    }

    return handler.next(err);
  }

  void _printKV(String key, Object? v) => _logger.append('$key: $v');

  void _printAll(dynamic msg) =>
      msg.toString().split('\n').forEach(_logger.append);

  void _printResponse(Response response, {bool isError = false}) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode);

      _logger.append('headers:');
      response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    }
    if (responseBody) {
      _logger.append('Response Text:');
      _printAll(response.toString());
    }
    _logger.closeAppend(isError: isError);
  }
}
