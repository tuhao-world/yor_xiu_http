import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yor_xiu_http_method_channel.dart';

abstract class YorXiuHttpPlatform extends PlatformInterface {
  /// Constructs a YorXiuHttpPlatform.
  YorXiuHttpPlatform() : super(token: _token);

  static final Object _token = Object();

  static YorXiuHttpPlatform _instance = MethodChannelYorXiuHttp();

  /// The default instance of [YorXiuHttpPlatform] to use.
  ///
  /// Defaults to [MethodChannelYorXiuHttp].
  static YorXiuHttpPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YorXiuHttpPlatform] when
  /// they register themselves.
  static set instance(YorXiuHttpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
