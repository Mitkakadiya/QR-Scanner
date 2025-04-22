import 'package:dio/dio.dart' as dio_link;

import 'api_config.dart';

class APIProvider {
  static dio_link.Dio? dio = dio_link.Dio(options);

  static dio_link.BaseOptions? options = dio_link.BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(milliseconds:100000 ),
      receiveTimeout: const Duration(milliseconds:100000 ),
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        }
        return false;
      });

  static dio_link.Dio getDio() {
    return dio!;
  }
}
