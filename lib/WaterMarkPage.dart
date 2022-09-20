import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ImageLoaderUtils.dart';

///图片生产水印
class WaterMarkPage extends StatefulWidget  {
  //任务ID
  late String imagePath;

  WaterMarkPage(this.imagePath, {Key? key}) : super(key: key);

  @override
  State<WaterMarkPage> createState() => _WaterMarkPageState();
}

class _WaterMarkPageState extends State<WaterMarkPage> {

  final GlobalKey _globalKey = GlobalKey();

  // AppBar buildAppBar() {
  //   return AppBar(
  //     title: Text(
  //       "签到图片",
  //       style: FontStyles.black(fontSize: 34.sp),
  //     ),
  //     elevation: 0,
  //     leading: BackButton(
  //       color: Colors.black,
  //     ),
  //     backgroundColor: Colors.transparent,
  //     centerTitle: true,
  //     actions: [
  //       IconTextButton(
  //           padding: EdgeInsets.only(right: 25.w),
  //           text: "保存",
  //           tapCallback: saveSignImg),
  //     ],
  //   );
  // }

  /**
   * 保存签到图片
   */
  Future<void> saveSignImg() async {
    ///通过globalkey将Widget保存为ui.Image
    ui.Image _image = await ImageLoaderUtils.imageLoader.getImageFromWidget(_globalKey);

    ///异步将这张图片保存在手机内部存储目录下
    String? localImagePath =  await ImageLoaderUtils.imageLoader.saveImageByUIImage(_image, isEncode: false);
    ///保存完毕后关闭当前页面并将保存的图片路径返回到上一个页面
    Get.back(result: localImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("图片上传"),
        actions: [
          IconButton(onPressed: saveSignImg,
          icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: RepaintBoundary(
            key: _globalKey,
            child: Stack(
              children: [
                Image.file(
                  File(widget.imagePath),
                  width: 500,
                  fit: BoxFit.fitWidth,
                ),
                const Positioned(
                    top: 20,
                    right: 20,
                    child: Text(
                        "data",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )
      ),
    );
  }
}