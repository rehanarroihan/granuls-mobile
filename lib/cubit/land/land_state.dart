part of 'land_cubit.dart';

abstract class LandState extends Equatable {
  const LandState();

  @override
  List<Object> get props => [];
}

class LandInitial extends LandState {}

class InitCreateLandPageInitial extends LandState {}

class InitCreateLandPageSuccessful extends LandState {}

class InitCreateLandPageFailed extends LandState {
  String message;

  InitCreateLandPageFailed(this.message);
}

class LandTestingRequestInit extends LandState {}

class LandTestingRequestSuccessful extends LandState {}

class LandTestingRequestFailed extends LandState {
  String message;

  LandTestingRequestFailed(this.message);
}

class SubmitLandTestingResultInitial extends LandState {}

class SubmitLandTestingResultSuccessful extends LandState {}

class SubmitLandTestingResultFailed extends LandState {
  String message;

  SubmitLandTestingResultFailed(this.message);
}
