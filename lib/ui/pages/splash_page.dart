import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/app.dart';
import 'package:granuls/ui/pages/auth/login_page.dart';
import 'package:granuls/ui/pages/auth/register_page.dart';
import 'package:granuls/ui/pages/main/main_menu_page.dart';
import 'package:granuls/utils/constant_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then((_) async {
      bool isLoggedIn = App().prefs.getBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN) ?? false;
      if (isLoggedIn) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => MainMenuPage()
        ), (Route<dynamic> route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64.w),
              child: const Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            SizedBox(
              height: 130.h,
            ),
            Text(
              'Solusi Rencana Pemupukan Awal Penanaman',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 130.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                right: 24.w,
                left: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              margin: EdgeInsets.only(bottom: 28.h),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginPage()
                  ));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => RegisterPage()
                ));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text(
                'Buat Akun Baru?',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
