import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
typedef StringCallBack =Function(String);
class Flutterzip {

  static  StreamController onProcessChange = new StreamController<Map>.broadcast();
  static const MethodChannel _channel = const MethodChannel('flutterzip');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }



  static Future<String> unpack(String unzipPath, String outPath) async {
    _channel.setMethodCallHandler(platformCallHandler);
    return await _channel.invokeMethod(
        'unpack', {"unzipPath": unzipPath, "outPath": outPath});
  }
  static Future<dynamic> platformCallHandler(MethodCall call) async {

    switch (call.method) {
      case "process":
        Map arguments = call.arguments;
        onProcessChange.add(arguments);

        break;
    }
}
  /// 关闭stream
  void closeStream() {
    _channel.setMethodCallHandler(null);
    onProcessChange.close();
  }
}
