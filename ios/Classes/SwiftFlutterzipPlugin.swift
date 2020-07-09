import Flutter
import UIKit
//SSZipArchiveDelegate
public class SwiftFlutterzipPlugin: NSObject, FlutterPlugin{
    var channell : FlutterMethodChannel?
    init(channell:FlutterMethodChannel) {
        self.channell = channell;
    }
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutterzip", binaryMessenger: registrar.messenger())
  
    let instance = SwiftFlutterzipPlugin.init(channell:channel);
    registrar.addMethodCallDelegate(instance, channel: channel)
   
  }


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  
    
    if(call.method=="unpack"){
        
   let arguments = call.arguments as! Dictionary<String, AnyObject>
   let outPath = arguments["outPath"] as! String
   let unzipPath = arguments["unzipPath"] as! String
//        SSZipArchive.unzipFile(atPath: unzipPath, toDestination: outPath,delegate: self);
//        result("ok");
           
    }
    
  }
    
    public func zipArchiveProgressEvent(_ loaded: UInt64, total: UInt64) {
        
//        var someDict:[String:UInt64] = ["total":total, "percent":loaded]
        if(total==loaded){
            
            print("Progress==done");
        }
        //channell?.invokeMethod("process", arguments:someDict)
        
    }
    
}
