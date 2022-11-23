import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/cubit/land/land_cubit.dart';
import 'package:granuls/models/request_land_testing_model.dart';
import 'package:granuls/ui/pages/land/land_testing_result_screen.dart';
import 'package:granuls/ui/widgets/modules/loading_dialog.dart';
import 'package:granuls/utils/show_flutter_toast.dart';
import 'package:lottie/lottie.dart';

class LandTestingScreen extends StatefulWidget {
  RequestLandTestingModel payload;
  String idDevice;
  String idTumbuhan;

  LandTestingScreen({
    Key? key,
    required this.payload,
    required this.idDevice,
    required this.idTumbuhan
  }) : super(key: key);

  @override
  _LandTestingScreenState createState() => _LandTestingScreenState();
}

class _LandTestingScreenState extends State<LandTestingScreen> {
  late LandCubit _landCubit;

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });

          if (_start == 0) {
            _landCubit.submitLandTestingResult(
              widget.payload.id!,
              widget.payload.title!,
              widget.idTumbuhan,
              widget.idDevice
            );
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _landCubit = BlocProvider.of<LandCubit>(context);

    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text(
              'Pembatan Pengujian',
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
            ),
            content: const Text('Apakah anda yakin ingin membatalkan pengujian tanah ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ya',
                  style: TextStyle(
                    color: Colors.red
                  )
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tidak'),
              ),
            ],
          ),
        );
      }
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Pengujian Gagal',
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          ),
          content: const Text('Gagal melakukan pengujian, pastikan alat pengujian aktif dan coba beberapa saat lagi.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Oke'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _landCubit,
      listener: (context, state) {
        if (state is SubmitLandTestingResultInitial) {
          LoadingDialog(
            title: 'Pengujian',
            description: 'Menyelesaikan pengujian...'
          ).show(context);
        } else if (state is SubmitLandTestingResultFailed) {
          Navigator.pop(context);
          _showErrorDialog();
          showFlutterToast(state.message);
        } else if (state is SubmitLandTestingResultSuccessful) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => LandTestingResultScreen(
              args: LandTestingResultScreenArgs(
                idTipeTanah: state.peylud.idTipeTanah!,
                idTumbuhan: state.peylud.idTumbuhan!,
                n: state.peylud.n!.floor(),
                p: state.peylud.p!.floor(),
                k: state.peylud.k!.floor(),
                kualitasTanah: state.tipeTanah
              ),
            )
          ));
          showFlutterToast("Pengujian Berhasil");
        }
      },
      child: BlocBuilder(
        bloc: _landCubit,
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => _onBackPressed(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350.h,
                      child: Lottie.asset('assets/lottie/hourglass.json')
                    ),
                    Text(
                      "Melakukan pengujian tanah",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    SizedBox(height: 8.h),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'harap tunggu dan tidak menutup halaman aplikasi ',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          TextSpan(
                            text: '($_start detik)',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          TextSpan(
                            text: '...',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  height: 48.h,
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
