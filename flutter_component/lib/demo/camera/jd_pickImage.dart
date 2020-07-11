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

class JDPickImagePage extends StatefulWidget {

  final String title = "jd_pickImage";

  @override
  _JDPickImagePageState createState() => _JDPickImagePageState();
}

class _JDPickImagePageState extends State<JDPickImagePage> {
  //获取控件的位置
  GlobalKey positionKey = GlobalKey();
  File _image;

  //拍照
  Future getImage() async {
    RenderBox renderBox = positionKey.currentContext.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    print(offset.dx);//横坐标
    print(offset.dy);//纵坐标

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

  void uploadImgFunc(File image) async {
    String path = image.path;
    String name = path.substring(path.lastIndexOf("/")+1,path.length);
    String suffix = name.substring(name.lastIndexOf(".")+1,name.length);
    FormData formData = FormData.fromMap(<String,dynamic>{
     "uploadFile": await MultipartFile.fromFile(
      path,
      filename: name,
       contentType: MediaType('image',suffix)//如果后端支持二进制方法上传就不需要此行
     ),
    });
    Dio dio = new Dio();
    var result = await dio.post<dynamic>("接口",data: formData);
    print(result);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: _image == null ? Text("No image selected."):Image.file(_image),
        ) ,
      floatingActionButton: FloatingActionButton(
        key: positionKey,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}