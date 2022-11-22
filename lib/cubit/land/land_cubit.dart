import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/device_model.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/services/device_service.dart';
import 'package:granuls/services/plant_service.dart';

part 'land_state.dart';

class LandCubit extends Cubit<LandState> {
  LandCubit() : super(LandInitial());
  final DeviceService _deviceService = DeviceService();
  final PlantService _plantService = PlantService();

  List<String> landList = [];
  bool isLandListLoading = false;

  List<DeviceModel> devices = [];
  List<PlantModel> plants = [];
  bool isInitCreateLandPageLoading = false;

  void getLandList() async {

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

    ApiResponse<List<PlantModel>> plantsResponse = await _plantService.getPlants();
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
}
