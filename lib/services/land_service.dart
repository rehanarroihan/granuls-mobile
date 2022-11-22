import 'package:dio/dio.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/pengujian_tanah_request.dart';
import 'package:granuls/models/pengujian_tanah_result_response.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/models/request_land_testing_model.dart';
import 'package:granuls/utils/url_constant_halper.dart';

class LandService {
  final Dio _dio = App().dio;
  final Dio _dioDeviceApi = App().deviceApiDio;

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

  Future<ApiResponse<String>> requestLandTesting(RequestLandTestingModel request) async {
    try {
      Response response = await _dioDeviceApi.post(
        UrlConstantHelper.POST_REQUEST_LAND_TEST,
        data: request.toJson()
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data.toString(),
        );
      }
      return ApiResponse(status: false, message: "Errorrr");
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          status: true,
          data: null,
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

  Future<ApiResponse<PengujianTanahResultResponse>> getLandTestingResult(String uuid) async {
    try {
      Response response = await _dio.get(
        UrlConstantHelper.GET_PENGUJIAN_TANAH_RESULT + "?id=" + uuid,
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: PengujianTanahResultResponse.fromJson(response.data),
        );
      }
      return ApiResponse(status: false, message: "Errorrr");
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          status: false,
          data: null,
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

  Future<ApiResponse<String>> submitLandTestingResult(PengujianTanahRequest request) async {
    try {
      Response response = await _dio.post(
        UrlConstantHelper.POST_PENGUJIAN_TANAH,
        data: request.toJson()
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          status: true,
          data: response.data.toString(),
        );
      }
      return ApiResponse(status: false, message: "Errorrr");
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
          status: false,
          data: null,
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