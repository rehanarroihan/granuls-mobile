import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceInitial());



  bool isDeviceListLoading = false;

  void getDeviceList() async {
    emit(GetDeviceListInitial());


  }
}
