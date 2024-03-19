import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// API
import 'package:erpalerts/api/endpoints.dart';

// Config
import 'package:erpalerts/config/prod.config.dart';

// Controllers
import 'package:erpalerts/controllers/auth.controller.dart';

// Managers
import 'package:erpalerts/managers/storage.manager.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  final String TAG = '[ApiClient]';

  late dio.Dio _dio;
  CookieJar cookieJar = CookieJar();
  String? _refreshToken;
  String? _authToken;

  factory ApiClient() {
    return _instance;
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _refreshToken = prefs.getString(StorageManager.REFRESH_TOKEN);
    _authToken = prefs.getString(StorageManager.TOKEN);

    if (_refreshToken != null) {
      // Add cookie value
      cookieJar.saveFromResponse(
        Uri.parse(Config.apiUrl),
        [
          Cookie('jwt', _refreshToken!),
        ],
      );
    }
  }

  void clear() {
    _refreshToken = null;
    _authToken = null;
    cookieJar.delete(Uri.parse(Config.apiUrl), true);
  }

  void resetUser() {
    clear();
    Get.find<AuthController>().reset();
  }

  ApiClient._internal() {
    _dio = dio.Dio();
    // Additional configuration for the Dio instance
    _dio.options.baseUrl = Config.apiUrl;
    // _dio.options.connectTimeout = 5000;
    _dio.options.connectTimeout = Duration(seconds: 10);
    // Add more configuration as needed

    // Cookie manager
    _dio.interceptors.add(CookieManager(cookieJar));

    // Add interceptor
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onResponse: _handleTokenResponse,
    ));

    // Add authentication token interceptor
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: _addAuthToken,
    ));

    // Add token refresh interceptor
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onError: _refreshTokenOnError,
    ));

    // Add error handling interceptor
    _dio.interceptors.add(dio.InterceptorsWrapper(
      onError: _handleError,
    ));
  }

  Future<dio.Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<dio.Response<T>> post<T>(String path, dynamic data) {
    return _dio.post<T>(path, data: data);
  }

  Future<dio.Response<T>> put<T>(String path, dynamic data) {
    return _dio.put<T>(path, data: data);
  }

  Future<dio.Response<T>> delete<T>(String path) {
    return _dio.delete<T>(path);
  }

  // Additional methods, interceptors, or configurations can be added here
  void _addAuthToken(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    // Retrieve the authentication token from wherever it's stored (e.g., local storage)

    if (_authToken != null) {
      options.headers['token'] = '$_authToken';
    }

    handler.next(options);
  }

  Future<void> _handleTokenResponse(dio.Response response, handler) async {
    // Extract token from response body
    final responseData = response.data;

    if (responseData == null) return handler.next(response);
    if (response.statusCode == 200) {
      final token = responseData['token'];

      if (token != null) {
        _authToken = token;

        // Extract cookies from response
        final cookies =
            await cookieJar.loadForRequest(response.requestOptions.uri);

        // Extract refresh token from cookies
        for (var cookie in cookies) {
          if (cookie.name == 'jwt') {
            _refreshToken = cookie.value;

            final prefs = await SharedPreferences.getInstance();
            prefs.setString(StorageManager.REFRESH_TOKEN, _refreshToken!);
            prefs.setString(StorageManager.TOKEN, _authToken!);
            break;
          }
        }
      }
    }

    return handler.next(response);
  }

  Future<void> _refreshTokenOnError(
      dio.DioError error, dio.ErrorInterceptorHandler handler) async {
    // Check the error response for authentication-related errors (e.g., token expired)

    // If 401 and no refresh token, return the error
    if (error.response?.statusCode == 401 && _refreshToken == null) {
      // Go to login screen
      resetUser();
      return handler.next(error);
    }

    // If 401 and attempt count is 2, return the error
    final int? attemptCount = error.requestOptions.headers['attempt'];
    if (error.response?.statusCode == 401 && attemptCount == 2) {
      // Go to login screen
      resetUser();
      return handler.next(error);
    }

    if (error.response?.statusCode == 401 && _refreshToken != null) {
      try {
        print(
            'error: ${error.response?.statusCode}  refreshToken:${_refreshToken != null}');

        // Perform token refresh logic here (e.g., using a separate API call)
        // Make a request to the token refresh endpoint and get the new token
        final responseData = await _performTokenRefresh();
        final String token = responseData.data['token'];

        _authToken = token;

        // Update the authentication token in the Dio instance
        _dio.options.headers['token'] = '$token';
        _dio.options.headers['attempt'] = 2;

        // Retry the failed request using _dio.request (which includes the updated token)
        dio.RequestOptions options = error.requestOptions;
        options.headers['token'] = '$token';
        var response = await _dio.request(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options:
              dio.Options(method: options.method, headers: options.headers),
        );

        // Return the response
        handler.resolve(response);
      } catch (refreshError) {
        // Token refresh failed, handle the error accordingly
        handler.reject(refreshError as dio.DioError);
      }
    }

    // Continue with the original error handling
    handler.next(error);
  }

  Future<dio.Response<dynamic>> _performTokenRefresh() {
    return _dio.post(Endpoints.refreshToken);
  }

  Future<void> _handleError(
      dio.DioError error, dio.ErrorInterceptorHandler handler) async {
    handler.next(error);
  }
}
