import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yor_xiu_common/config/top_level_obj.dart';
import 'package:yor_xiu_common/utils/token_helper.dart';
import 'package:yor_xiu_common/yor_xiu_common.dart';
import 'package:yor_xiu_http/dio/http_exception.dart';


/// 自定义拦截器
class DioInterceptor extends InterceptorsWrapper{
  final showLog = true;
  @override
  void onRequest(RequestOptions? options, RequestInterceptorHandler handler) async{
    options?.headers.addAll({'Authorization': 'Bearer ${TokenHelper.token}'});
    options?.headers.addAll({'client-type': Platform.isMacOS?'Mac':'Windows'});

    logger.v('拦截器：token=${TokenHelper.token}');
    /// 在这里，你可以添加请求前添加token，加密，解密等操作
    super.onRequest(options!,handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var appException = CustomHttpException.create(err);
    err.error = appException;
    logger.w('========>>>>>>>onError:${err.toString()}-----${YorXiuCommon.getBaseUrl()+err.requestOptions.path}');

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var baseUrl = response.requestOptions.baseUrl;
    var path = response.requestOptions.path;
    var data = response.data;
    var statusCode = response.statusCode;


    final queryParameters = response.requestOptions.queryParameters;

    final requestData = response.requestOptions.data;


    if(statusCode != 200){
      var dio = DioError(requestOptions: response.requestOptions,type: DioErrorType.connectTimeout);
      CustomHttpException.create(dio);
      handler.reject(dio);
    }else{
      final method = response.requestOptions.method.toUpperCase();
      logger.v(''
          '========>>>>>>>请求方式: $method'
          '\n========>>>>>>>请求地址: ${baseUrl+path}'
          '\n========>>>>>>>请求参数: ${method == 'GET'?queryParameters:requestData}'
          '\n========>>>>>>>响应内容: ${showLog?data:''}'
          );
      super.onResponse(response, handler);
    }
  }

}