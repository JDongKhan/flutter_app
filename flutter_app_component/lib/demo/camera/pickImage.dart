import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

/**
 *
 * @author jd
 *
 */

class PickImagePage extends StatefulWidget {
  final String title = "jd_pickImage";

  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File _image;

  //拍照
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    uploadImgFunc(image);
    setState(() {
      _image = image;
    });
  }

  //相册
  Future openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    uploadImgFunc(image);
    setState(() {
      _image = image;
    });
  }

  //相册
  Future openGallery2() async {
    // final List assetList = await PhotoPicker.pickAsset(context: context);
    // print(assetList);
  }

  void uploadImgFunc(File image) async {
    String path = image.path;
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);
    String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = FormData.fromMap(<String, dynamic>{
      'uploadFile': await MultipartFile.fromFile(path,
          filename: name,
          contentType: MediaType('image', suffix) //如果后端支持二进制方法上传就不需要此行
          ),
    });
    Dio dio = Dio();
    var result = await dio.post<dynamic>('接口', data: formData);
    debugPrint(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  openGallery();
                },
                child: Text('相册'),
              ),
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: Text('拍照'),
              ),
              TextButton(
                onPressed: () {
                  openGallery2();
                },
                child: Text('photo 相册'),
              ),
            ],
          ),
          Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(_image),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
