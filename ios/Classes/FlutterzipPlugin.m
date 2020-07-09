#import "FlutterzipPlugin.h"
#if __has_include(<flutterzip/flutterzip-Swift.h>)
#import <flutterzip/flutterzip-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterzip-Swift.h"
#endif
#import "SSZipArchive/ZipArchive.h"
@implementation FlutterzipPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  [SwiftFlutterzipPlugin registerWithRegistrar:registrar];
    FlutterMethodChannel* channel = [FlutterMethodChannel  methodChannelWithName:@"flutterzip" binaryMessenger:[registrar messenger]];
    FlutterzipPlugin* instance = [[FlutterzipPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"unpack" isEqualToString:call.method]){
     NSString *outPath = call.arguments[@"outPath"];
      NSString *unzipPath = call.arguments[@"unzipPath"];
      @try{
          BOOL success = [SSZipArchive unzipFileAtPath:unzipPath toDestination:outPath];
               if(success){
                    result(@"ok");
               }
          @catch(NSException *exception) {
              printf(@"SSZipArchive==NSException")
          }
      
  }
}

@end
