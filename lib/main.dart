import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'WaterMarkPage.dart';
import 'data_img_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //拍照
    XFile? file = await ImagePicker.platform.getImage(source: ImageSource.camera,imageQuality:50).then((value) async {
      if(value != null){
        print(value.path);
        File file = await imageAddWaterMark(value.path,"测试wwwwww");
        print(file.path);
      }

    });

//拍照图传至WaterMarkPage返回水印图
//     Get.to(WaterMarkPage(file!.path))?.then((newSignImg){
//       print(newSignImg);
//       File file = new File(newSignImg);
//       print(file.existsSync());
//       //上传水印图
//       // ApiCommonRequest.uploadFile(HttpUrls.api_img_upload, newSignImg, Constants.FILE_IMAGE, onSuccess: (String fileUrl) {
//       //   print("图片上传成功:${fileUrl}");
//       // });
//     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
