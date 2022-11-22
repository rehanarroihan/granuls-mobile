import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:granuls/cubit/land/land_cubit.dart';
import 'package:granuls/models/device_model.dart';
import 'package:granuls/models/plant_model.dart';
import 'package:granuls/utils/show_flutter_toast.dart';
import 'package:lottie/lottie.dart';

class CreateLandScreen extends StatefulWidget {
  const CreateLandScreen({Key? key}) : super(key: key);

  @override
  _CreateLandScreenState createState() => _CreateLandScreenState();
}

class _CreateLandScreenState extends State<CreateLandScreen> {
  late LandCubit _landCubit;

  Position? position;
  String currentAddress = "Getting location...";

  PlantModel? _selectedPlant = null;
  TextEditingController _landSurfaceAreaController = TextEditingController();
  DeviceModel? _selectedDevice = null;

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
        Placemark place = placemarks[0];
        setState(() {
          currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
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
