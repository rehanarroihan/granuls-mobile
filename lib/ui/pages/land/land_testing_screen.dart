import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LandTestingScreen extends StatefulWidget {
  const LandTestingScreen({Key? key}) : super(key: key);

  @override
  _LandTestingScreenState createState() => _LandTestingScreenState();
}

class _LandTestingScreenState extends State<LandTestingScreen> {
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

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
            title: Text(
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
                child: Text(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(),
      child: Scaffold(
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
  }
}
