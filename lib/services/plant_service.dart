import 'package:dio/dio.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/utils/url_constant_halper.dart';

class PlantService {
  final Dio _dio = App().dio;

  Future<ApiResponse<List<PlantModel>>> getPlants() async {
    try {
      Response response = await _dio.get(
        UrlConstantHelper.GET_PLANTS,
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data != null ? List.generate(response.data.length, (index) {
            return PlantModel.fromJson(response.data[index]);
          }) : [],
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

  Future<ApiResponse<String>> checkDevice(String deviceCode) async {
    try {
      Response response = await _dio.get(
        UrlConstantHelper.GET_DEVICE_CHECK + "?id=" + deviceCode,
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data['result'],
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

  Future<ApiResponse<String>> createDevice(String deviceId) async {
    try {
      Response response = await _dio.post(
        UrlConstantHelper.POST_CREATE_DEVICE,
        data: {
          "id_device": deviceId,
        }
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data['result'].toString(),
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