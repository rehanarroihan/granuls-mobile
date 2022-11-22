import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/device_model.dart';
import 'package:granuls/services/device_service.dart';

part 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceInitial());
  final DeviceService _deviceService = DeviceService();

  List<DeviceModel> devices = [];
  bool isDeviceListLoading = false;

  bool isDeviceRegisterLoading = false;

  void registerDevice(String deviceCode) async {
    isDeviceRegisterLoading = true;
    emit(RegisterDeviceInit());

    ApiResponse<String> checkDeviceResponse = await _deviceService.checkDevice(deviceCode);
    if (checkDeviceResponse.status && checkDeviceResponse.data != null) {
      ApiResponse<String> registerDeviceResponse = await _deviceService.createDevice(checkDeviceResponse.data!);
      isDeviceRegisterLoading = false;
      if (registerDeviceResponse.status) {
        emit(RegisterDeviceSuccessful());
      } else {
        emit(const RegisterDeviceFailed(message: "Gagal registrasi device baru"));
      }
    } else {
      isDeviceRegisterLoading = false;
      emit(const RegisterDeviceFailed(message: "ID alat tidak valid"));
    }
  }

  void getDeviceList() async {
    devices.clear();
    isDeviceListLoading = true;
    emit(GetDeviceListInitial());

    ApiResponse<List<DeviceModel>> apiReturn = await _deviceService.getDevices();
    isDeviceListLoading = false;
    if (apiReturn.status) {
      if (apiReturn.data != null) {
        devices.addAll(apiReturn.data!);
      }
      emit(DeviceListLoadedSuccessfully());
    } else {
      emit(DeviceListLoadFailed());
    }
  }
}
