import 'package:dio/dio.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/user_model.dart';
import 'package:granuls/utils/url_constant_halper.dart';

class DeviceService {
  final Dio _dio = App().dio;

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