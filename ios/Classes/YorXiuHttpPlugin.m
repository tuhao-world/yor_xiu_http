#import "YorXiuHttpPlugin.h"
#if __has_include(<yor_xiu_http/yor_xiu_http-Swift.h>)
#import <yor_xiu_http/yor_xiu_http-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yor_xiu_http-Swift.h"
#endif

@implementation YorXiuHttpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYorXiuHttpPlugin registerWithRegistrar:registrar];
}
@end
