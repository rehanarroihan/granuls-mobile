import 'package:dio/dio.dart';
import 'package:granuls/utils/constant_helper.dart';
import 'package:granuls/utils/global_method_helper.dart';
import 'package:granuls/utils/url_constant_halper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App {
  static App? _instance;
  final String? apiBaseURL;
  final String? appTitle;

  late SharedPreferences prefs;
  late Dio dio;
  late Dio deviceApiDio;

  App.configure({
    this.apiBaseURL,
    this.appTitle
  }) {
    _instance = this;
  }

  factory App() {
    if (_instance == null) {
      throw UnimplementedError("App must be configured first.");
    }

    return _instance!;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    _initDio();
  }

  void _initDio() {
    dio = Dio(BaseOptions(
      baseUrl: apiBaseURL!,
      connectTimeout: 10000,
      receiveTimeout: 50000,
      responseType: ResponseType.json
    ));

    deviceApiDio = Dio(BaseOptions(
      baseUrl: UrlConstantHelper.DEVICE_SERVER_ADDRESS,
      connectTimeout: 10000,
      receiveTimeout: 50000,
      responseType: ResponseType.json
    ));

    if (!GlobalMethodHelper.isEmpty(prefs.get(ConstantHelper.PREFS_TOKEN_KEY))) {
      dio.options.headers = {
        'Authorization': 'Bearer ${prefs.get(ConstantHelper.PREFS_TOKEN_KEY)}'
      };
    }

    dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) async {
      //Map<String, dynamic> data = e.response.data;
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 400) {}
        // INFO : Kicking out user to login page when !authenticated
        if (e.response?.statusCode == 401) {
          //String message = data['message'];
        }
      }
      return handler.next(e);
    }));
  }
}