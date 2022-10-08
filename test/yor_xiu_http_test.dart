import 'package:flutter_test/flutter_test.dart';
import 'package:yor_xiu_http/yor_xiu_http.dart';
import 'package:yor_xiu_http/yor_xiu_http_platform_interface.dart';
import 'package:yor_xiu_http/yor_xiu_http_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYorXiuHttpPlatform 
    with MockPlatformInterfaceMixin
    implements YorXiuHttpPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YorXiuHttpPlatform initialPlatform = YorXiuHttpPlatform.instance;

  test('$MethodChannelYorXiuHttp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYorXiuHttp>());
  });

  test('getPlatformVersion', () async {
    YorXiuHttp yorXiuHttpPlugin = YorXiuHttp();
    MockYorXiuHttpPlatform fakePlatform = MockYorXiuHttpPlatform();
    YorXiuHttpPlatform.instance = fakePlatform;
  
    expect(await yorXiuHttpPlugin.getPlatformVersion(), '42');
  });
}
