import 'package:dio/dio.dart';
import 'package:hm_demo/constants/index.dart';
import 'package:hm_demo/providers/token_manager.dart';

class _DioClient {
  final _dio = Dio();
  final timeOut = Duration(seconds: GlobeConstants.timeOut);
  _DioClient() {
    _dio.options = BaseOptions(
      baseUrl: GlobeConstants.baseUrl,
      connectTimeout: timeOut,
      sendTimeout: timeOut,
      receiveTimeout: timeOut,
    );
    _addInterceptors();
  }
  Future get(String path) async {
    final response = await _dio.get(path);
    return response.data['result'];
  }

  Future post(String path, Map<String, dynamic> data) async {
    final response = await _dio.post(path, data: data);
    return response.data['result'];
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await tokenManager.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.data['code'] != GlobeConstants.successCode) {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                error: response.data['msg'] ?? '业务码错误',
              ),
            );
          } else {
            handler.next(response);
          }
        },
        onError: (error, handler) {
          if (error.error != null) {
            handler.next(error);
          } else {
            handler.next(
              DioException(
                requestOptions: error.requestOptions,
                error: '网络请求错误',
              ),
            );
          }
        },
      ),
    );
  }
}

final dioClient = _DioClient();
