part of 'device_cubit.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

class DeviceInitial extends DeviceState {}

class GetDeviceListInitial extends DeviceState {}

class DeviceListLoadedSuccessfully extends DeviceState {}

class DeviceListLoadFailed extends DeviceState {}
