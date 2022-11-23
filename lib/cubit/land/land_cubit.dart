import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/device_model.dart';
import 'package:granuls/models/fertilizer_response_model.dart';
import 'package:granuls/models/pengujian_tanah_request.dart';
import 'package:granuls/models/pengujian_tanah_response.dart';
import 'package:granuls/models/pengujian_tanah_result_response.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/models/request_land_testing_model.dart';
import 'package:granuls/services/device_service.dart';
import 'package:granuls/services/land_service.dart';
import 'package:granuls/utils/constant_helper.dart';
import 'package:uuid/uuid.dart';

part 'land_state.dart';

class LandCubit extends Cubit<LandState> {
  LandCubit() : super(LandInitial());
  final DeviceService _deviceService = DeviceService();
  final LandService _landService = LandService();

  List<PengujianTanahResponse> landList = [];
  bool isLandListLoading = false;

  List<DeviceModel> devices = [];
  List<PlantModel> plants = [];
  bool isInitCreateLandPageLoading = false;

  List<FertilizerResponseModel> fertilizerList = [];
  bool isGetFertilizerRecommendation = false;

  void getLandList() async {
    isLandListLoading = true;
    emit(GetLandInitial());

    ApiResponse<List<PengujianTanahResponse>> apiReturn = await _landService.getLandList();
    if (apiReturn.data != null) {
      landList.clear();
      landList.addAll(apiReturn.data!);
    }

    isLandListLoading = false;
    emit(GetLandSuccessful());
  }

  void initCreateLandPage() async {
    isInitCreateLandPageLoading = true;
    emit(InitCreateLandPageInitial());

    ApiResponse<List<DeviceModel>> apiReturn = await _deviceService.getDevices();
    if (!apiReturn.status) {
      isInitCreateLandPageLoading = false;
      emit(InitCreateLandPageFailed('Gagal mendapatkan list alat'));
      return;
    }

    if (apiReturn.data != null) {
      devices.clear();
      devices.addAll(apiReturn.data!);
    }

    ApiResponse<List<PlantModel>> plantsResponse = await _landService.getPlants();
    if (!plantsResponse.status) {
      isInitCreateLandPageLoading = false;
      emit(InitCreateLandPageFailed('Gagal mendapatkan list tanaman'));
      return;
    }

    if (plantsResponse.data != null) {
      plants.clear();
      plants.addAll(plantsResponse.data!);
    }

    isInitCreateLandPageLoading = false;
    emit(InitCreateLandPageSuccessful());
  }

  void requestLandTesting(RequestLandTestingModel payload) async {
    emit(LandTestingRequestInit());

    ApiResponse<String> request = await _landService.requestLandTesting(payload);
    if (request.status) {
      emit(LandTestingRequestSuccessful());
    } else {
      emit(LandTestingRequestFailed('Gagal request uji lahan'));
    }
  }

  void submitLandTestingResult(String uuid, String title, String idTumbuhan, String idDevice) async {
    emit(SubmitLandTestingResultInitial());
    ApiResponse<PengujianTanahResultResponse> request = await _landService.getLandTestingResult(uuid);
    if (request.status) {
      PengujianTanahRequest peylud = PengujianTanahRequest(
        id: const Uuid().v4(),
        title: title,
        idUser: App().prefs.getString(ConstantHelper.PREFS_USER_ID),
        idTumbuhan: idTumbuhan,
        idDevice: idDevice,
        idTipeTanah: request.data!.idTipeTanah,
        n: request.data!.n!.floor(),
        p: request.data!.p!.floor(),
        k: request.data!.k!.floor(),
        ph: 0
      );
      ApiResponse<String> secondRequest = await _landService.submitLandTestingResult(peylud);
      if (secondRequest.status) {
        emit(SubmitLandTestingResultSuccessful(peylud, request.data!.kualitas!));
      } else {
        emit(SubmitLandTestingResultFailed('Gagal memproses hasil pengujian'));
      }
    } else {
      emit(SubmitLandTestingResultFailed('Gagal mendapatkan hasil pengujian'));
    }
  }

  void getVertilizerRecommendation(
    String idTipeTanah,
    String idTumbuhan,
    String luas
  ) async {
    isGetFertilizerRecommendation = true;
    emit(GetVertilizerRecommendationInit());

    ApiResponse<List<FertilizerResponseModel>> apiResult = await _landService.getFertilizerRecommendationList(
      idTipeTanah, idTumbuhan, luas
    );
    if (apiResult.data != null) {
      fertilizerList.clear();
      fertilizerList.addAll(apiResult.data!);
    }

    isGetFertilizerRecommendation = false;
    emit(GetVertilizerRecommendationSuccessful());
  }
}
