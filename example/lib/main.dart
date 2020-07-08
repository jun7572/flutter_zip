import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterzip/flutterzip.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    if(Platform.isIOS){
        initPath();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Flutterzip.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  String unzipPath="/storage/emulated/0/aa_flutter/2-05 The Go-Kart.zip";
//  String unzipPath="/storage/emulated/0/aa_flutter/1592808973784462.avi 2.zip";
  String outPath="/storage/emulated/0/aa_flutter/2-05 The Go-Kart/";
  var directory;
  initPath()async{


//    unzipPath=getDownloadsDirectory().toString()+"/2-05 The Go-Kart.zip";
  //下载到手机
  String  s="http://139.199.153.108:8080/2-05%20The%20Go-Kart.zip";
   directory = await getTemporaryDirectory();

//  var savePath=directory.path+"/2-05 The Go-Kart.zip";
   unzipPath=directory.path+"/2-05 The Go-Kart.zip";
    outPath=directory.path+"/2-05 The Go-Kart";
//  var response = await Dio().download(s,savePath);

  //查看文件
//   print("response.toString()=="+response.toString());
//  List<FileSystemEntity>  listSync = directory.listSync();
//  for(FileSystemEntity f in listSync){
//    print("====="+f.path);
//  }

//    unzipPath=directory.toString();
    print("unzipPath==="+unzipPath);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            RaisedButton(
              onPressed: (){
                  Flutterzip.unpack(unzipPath, outPath);
                  Flutterzip.onProcessChange.stream.listen((event) {
                    print("========="+event.toString());
                  });
              },
              child: Text("解压"),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: (){

                viewList();

              },
              child: Text("查看目录"),
            ),
          ],
        ),
      ),
    );
  }

   viewList()async{
     //查看文件
  List<FileSystemEntity>  listSync = directory.listSync();
  for(FileSystemEntity f in listSync){
    print("====="+f.path);
  }

  }
}
