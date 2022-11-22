import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:granuls/app.dart';
import 'package:granuls/cubit/land/land_cubit.dart';
import 'package:granuls/models/device_model.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/models/request_land_testing_model.dart';
import 'package:granuls/ui/pages/land/land_testing_screen.dart';
import 'package:granuls/ui/widgets/modules/loading_dialog.dart';
import 'package:granuls/utils/constant_helper.dart';
import 'package:granuls/utils/show_flutter_toast.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class CreateLandScreen extends StatefulWidget {
  const CreateLandScreen({Key? key}) : super(key: key);

  @override
  _CreateLandScreenState createState() => _CreateLandScreenState();
}

class _CreateLandScreenState extends State<CreateLandScreen> {
  late LandCubit _landCubit;

  Position? position;
  String currentAddress = "Getting location...";

  Placemark? place;
  PlantModel? _selectedPlant = null;
  TextEditingController _landSurfaceAreaController = TextEditingController();
  DeviceModel? _selectedDevice = null;
  RequestLandTestingModel? payload = null;

  @override
  void initState() {
    super.initState();

    _determinePosition();

    _landCubit = BlocProvider.of<LandCubit>(context);
    _landCubit.initCreateLandPage();
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    if (position?.latitude != null && position?.longitude != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
      if (placemarks.isNotEmpty) {
        place = placemarks[0];
        setState(() {
          currentAddress = "${place!.street}, ${place!.subLocality}, ${place!.locality}, ${place!.postalCode}, ${place!.country}";
        });
      }
    }

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _landCubit,
      listener: (context, state) {
        if (state is InitCreateLandPageFailed) {
          showFlutterToast(state.message);
        }

        if (state is LandTestingRequestInit) {
          LoadingDialog(
            title: 'Pengujian',
            description: 'Memulai pengujian...'
          ).show(context);
        } else if (state is LandTestingRequestFailed) {
          Navigator.pop(context);
          showFlutterToast(state.message);
        } else if (state is LandTestingRequestSuccessful) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => LandTestingScreen(
              payload: payload!,
              idDevice: _selectedDevice!.id!,
              idTumbuhan: _selectedPlant!.id!,
            )
          ));
        }
      },
      child: BlocBuilder(
        bloc: _landCubit,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Tambah Lahan',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
            body: _landCubit.isInitCreateLandPageLoading ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 60.h,
                    child: Lottie.asset('assets/lottie/loading_animation.json')
                  ),
                )
              ],
            ) :
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownSearch<PlantModel>(
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: _landCubit.plants,
                      itemAsString: (PlantModel tanduran) => tanduran.namaTumbuhan.toString(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pilih tanaman yang akan ditanam",
                        ),
                      ),
                      onChanged: (selected) {
                        setState(() {
                          _selectedPlant = selected;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _landSurfaceAreaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Luas Tanah (Ha)',
                        labelText: "Luas Tanah (Ha)"
                      ),
                    ),
                    SizedBox(height: 16.h),
                    DropdownSearch<DeviceModel>(
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: _landCubit.devices,
                      itemAsString: (DeviceModel alat) => alat.kodeDevice.toString(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Pilih Alat Granuls",
                        ),
                      ),
                      onChanged: (selected) {
                        setState(() {
                          _selectedDevice = selected;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: !_landCubit.isInitCreateLandPageLoading ? Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                right: 24.w,
                left: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              margin: EdgeInsets.only(bottom: 28.h),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedPlant == null) {
                    showFlutterToast('Pilih tanaman terlibih dahulu');
                    return;
                  }

                  if (_landSurfaceAreaController.text.isEmpty) {
                    showFlutterToast('Isi luas tanah terlebih dahulu');
                    return;
                  }

                  if (_selectedDevice == null) {
                    showFlutterToast('Pilih alat terlebih dahulu');
                    return;
                  }

                  DateTime dateTimeNow = DateTime.now();
                  DateTime dateTimeWIB = dateTimeToZone(zone: "WIB", datetime: dateTimeNow);

                  payload = RequestLandTestingModel(
                    id: const Uuid().v4(),
                    deviceId: _selectedDevice!.kodeDevice,
                    title: "Pengujian ${App().prefs.get(ConstantHelper.PREFS_USERNAME)} - ${DateFormat('yyyy/MM/dd HH:mm').format(dateTimeWIB)}",
                    lat: position!.latitude,
                    lng: position!.longitude,
                    kab: place!.administrativeArea,
                    startAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTimeWIB),
                    endAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTimeWIB.add(const Duration(seconds: 30))),
                  );
                  _landCubit.requestLandTesting(payload!);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Mulai Uji Tanah',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
            ) : null
          );
        },
      ),
    );
  }
}
