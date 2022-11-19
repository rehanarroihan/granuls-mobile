import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/cubit/auth/auth_cubit.dart';
import 'package:granuls/ui/pages/main/main_menu_page.dart';
import 'package:granuls/ui/widgets/modules/loading_dialog.dart';
import 'package:granuls/utils/show_flutter_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthCubit _authCubit;

  final TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener(
      bloc: _authCubit,
      listener: (context, state) {
        if (state is UserLoginInit) {
          LoadingDialog(
            title: 'Login',
            description: 'Mengautentikasi...'
          ).show(context);
        } else if (state is UserLoginSuccessful) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MainMenuPage()
          ));
        } else if (state is UserLoginFailed) {
          Navigator.pop(context);
          showFlutterToast(state.message);
        }
      },
      child: BlocBuilder(
        bloc: _authCubit,
        builder: (context, state) {
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
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 84.h),

                ],
              ),
            ),
            bottomNavigationBar: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                right: 24.w,
                left: 24.w,
                bottom: MediaQuery.of(context).viewInsets.bottom
              ),
              margin: EdgeInsets.only(bottom: 28.h),
              child: ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username.isNotEmpty && password.isNotEmpty) {
                    _authCubit.loginUser(username, password);
                  }
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
          );
        }
      ),
    );
  }
}
