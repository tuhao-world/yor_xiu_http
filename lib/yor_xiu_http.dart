
import 'yor_xiu_http_platform_interface.dart';

class YorXiuHttp {
  Future<String?> getPlatformVersion() {
    return YorXiuHttpPlatform.instance.getPlatformVersion();
  }
}
