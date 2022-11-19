import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:granuls/app.dart';
import 'package:granuls/models/api_response.dart';
import 'package:granuls/models/user_model.dart';
import 'package:granuls/services/auth_service.dart';
import 'package:granuls/utils/constant_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService _authService = AuthService();

  void loginUser(String username, String password) async {
    emit(UserLoginInit());

    ApiResponse<String?> loginResult = await _authService.userLogin(username, password);
    if (loginResult.status) {
      App().prefs.setString(ConstantHelper.PREFS_TOKEN_KEY, loginResult.data!);
      App().dio.options.headers = {
        'Authorization': 'Bearer ${loginResult.data}'
      };

      ApiResponse<UserModel> userDetailResult = await _authService.getUserDetail();
      if (userDetailResult.status) {
        App().prefs.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, true);
        App().prefs.setString(ConstantHelper.PREFS_USER_ID, userDetailResult.data!.id!);
        App().prefs.setString(ConstantHelper.PREFS_USERNAME, userDetailResult.data!.username!);
        App().prefs.setString(ConstantHelper.PREFS_USER_FULL_NAME, userDetailResult.data!.nama!);

        emit(UserLoginSuccessful(userData: userDetailResult.data!));
      } else {
        emit(const UserLoginFailed(message: "Gagal mendapatkan detail user"));
      }
    } else {
      emit(UserLoginFailed(message: loginResult.message ?? "Sistem error"));
    }
  }
}