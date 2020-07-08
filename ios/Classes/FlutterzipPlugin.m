#import "FlutterzipPlugin.h"
#if __has_include(<flutterzip/flutterzip-Swift.h>)
#import <flutterzip/flutterzip-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterzip-Swift.h"
#endif

@implementation FlutterzipPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterzipPlugin registerWithRegistrar:registrar];
    
}
@end
