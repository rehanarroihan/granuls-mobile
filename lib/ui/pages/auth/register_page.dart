import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:granuls/cubit/auth/auth_cubit.dart';
import 'package:granuls/ui/pages/main/main_menu_page.dart';
import 'package:granuls/ui/widgets/modules/loading_dialog.dart';
import 'package:granuls/utils/show_flutter_toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthCubit _authCubit;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        if (state is UserRegisterInit) {
          LoadingDialog(
            title: 'Register',
            description: 'Melakukan registrasi...'
          ).show(context);
        } else if (state is UserRegisterSuccessful) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) => const MainMenuPage()
          ), (Route<dynamic> route) => false);
        } else if (state is UserRegisterFailed) {
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
                    'Daftar',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 32.h),
                  TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nama Lengkap',
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
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
                  String fullName = _fullNameController.text;
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (fullName.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
                    _authCubit.registerUser(fullName, username, password);
                  } else {
                    showFlutterToast("Lengkapi form terlebih dahulu");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
            ),
          );
        },
      ),
    );
  }
}
