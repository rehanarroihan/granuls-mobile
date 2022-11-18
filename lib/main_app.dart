import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:granuls/app.dart';
import 'package:granuls/cubit/auth/auth_cubit.dart';
import 'package:granuls/ui/pages/splash_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = AuthCubit();

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => authCubit),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp(
              title: App().appTitle!,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: GoogleFonts.latoTextTheme(
                    ThemeData(brightness: Brightness.light).textTheme),
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFF44BB77)),
              ),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              home: const SplashPage(),
            );
          },
        ));
  }
}
