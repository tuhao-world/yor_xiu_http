import 'package:dio/dio.dart';
import 'package:yor_xiu_common/yor_xiu_common.dart';
import 'package:yor_xiu_http/dio/base_res.dart';
import 'package:yor_xiu_http/dio/dio_intercepter.dart';

enum Method { get, post, put, delete }

typedef OnSuccess = Future Function(dynamic data);
typedef OnError = Future Function(int code, String msg);

class HttpManager {
  ///静态当前实例对象，用于使用单例模式
  static HttpManager? _instance;

  late Dio _dio;

  ///创建私有的构造方法，仅供当前类使用 避免外部初始化
  HttpManager._internal() {
    _init();
  }

  ///由于dart为单线程模型，所有代码均运行在同一个isolate中
  ///这里不考虑线程安全的创建方式
  static HttpManager get instance {
    _instance ??= HttpManager._internal();
    return _instance!;
  }

  void _init() {
    _dio = Dio();
    final baseOptions = BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 60000000,
        //接收超时
        sendTimeout: 30000,
        responseType: ResponseType.json,
        baseUrl: YorXiuCommon.getBaseUrl(),
        validateStatus: (statues) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        });
    _dio.options = baseOptions;
    _dio.interceptors.add(DioInterceptor());
  }

  void commonCall(
      {required Response response,
      OnSuccess? onSuccess,
      OnError? onError,
      ProgressCallback? onSendProgress}) {
    if (response.statusCode == 200) {
      BaseRes res = BaseRes.fromJson(response.data);
      if (res.isSuccess) {
        onSuccess?.call(res.data);
      } else {
        onError?.call(res.code ?? -1, res.message ?? '');
      }
    } else {
      onError?.call(response.statusCode ?? -2, response.statusMessage ?? '');
    }
  }

  void get(String api,
      {Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      OnSuccess? onSuccess,
      OnError? onError}) async {
    final reponse = await _dio.get(api,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
    commonCall(response: reponse, onSuccess: onSuccess, onError: onError);
  }

  void post(String api,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      Options? options,
      OnSuccess? onSuccess,
      OnError? onError}) async {
    final response = await _dio.post(api,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress);
    commonCall(
        response: response,
        onSuccess: onSuccess,
        onError: onError,
        onSendProgress: onSendProgress);
  }

  void put(String api,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      Options? options,
      OnSuccess? onSuccess,
      OnError? onError}) async {
    final response = await _dio.put(api,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress);
    commonCall(
        response: response,
        onSuccess: onSuccess,
        onError: onError,
        onSendProgress: onSendProgress);
  }

  void delete(String api,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      Options? options,
      OnSuccess? onSuccess,
      OnError? onError}) async {
    final response = await _dio.delete(
      api,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
    );
    commonCall(
        response: response,
        onSuccess: onSuccess,
        onError: onError,
        onSendProgress: onSendProgress);
  }

  void request(String api,
      {Method method = Method.get,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      ProgressCallback? onSendProgress,
      OnSuccess? onSuccess,
      OnError? onError}) async {
    final response = await _dio.request(
      api,
      options: Options(method: method.name),
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
    );
    commonCall(response: response,onSendProgress: onSendProgress,onSuccess: onSuccess,onError: onError);
  }
}
