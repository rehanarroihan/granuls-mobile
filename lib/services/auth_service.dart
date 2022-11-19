import 'package:dio/dio.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/user_model.dart';
import 'package:granuls/utils/url_constant_halper.dart';

class AuthService {
  final Dio _dio = App().dio;

  Future<ApiResponse<String?>> userLogin(String username, String password) async {
    try {
      Response response = await _dio.post(
        UrlConstantHelper.POST_AUTH_LOGIN,
        data: {
          "username": username,
          "password": password
        }
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data['result'],
        );
      }

      return ApiResponse(status: false, message: 'Username atau password salah');
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          status: false,
          message: 'Username atau password salah'
        );
      } else {
        return ApiResponse(
          status: false,
          message: 'Service unavailable'
        );
      }
    }
  }

  Future<ApiResponse<UserModel>> getUserDetail() async {
    try {
      Response response = await _dio.get(
        UrlConstantHelper.GET_USER_DETAIL,
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: UserModel.fromJson(response.data),
        );
      }

      return ApiResponse(status: false, message: "Errorrr");
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          status: false,
          message: 'Bad request'
        );
      } else {
        return ApiResponse(
          status: false,
          message: 'Service unavailable'
        );
      }
    } catch(e, stackTrace) {
      return ApiResponse(
        status: false,
        message: 'Sistem error'
      );
    }
  }
}