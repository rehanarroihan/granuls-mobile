import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Masuk',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 32.h),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 84.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LoginPage()
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
