import 'dart:io';

import 'package:dio/dio.dart';

import 'end_points.dart';
import 'network_exceptions.dart';

class DioClient {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: 2000,
      receiveTimeout: 2000,
    ),
  )..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: true,
        requestBody: true,
      ),
    );

  static String handleError(Object e) {
    return NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(e));
  }

  static Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      var response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> post({
    required String endPoint,
    Map<String, dynamic> params = const {},
  }) async {
    try {
      var response = await _dio.post(
        '${EndPoints.baseUrl}$endPoint',
        data: params,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }
}
