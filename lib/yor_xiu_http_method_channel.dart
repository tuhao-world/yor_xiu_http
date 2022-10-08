import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yor_xiu_http_platform_interface.dart';

/// An implementation of [YorXiuHttpPlatform] that uses method channels.
class MethodChannelYorXiuHttp extends YorXiuHttpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yor_xiu_http');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
