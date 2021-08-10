import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  @override
  State createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("assets/images/head.png");

    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Image>[
          Image.network(
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579521477523&di=dea28426b82dc5dde05d3390cd6bfc36&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01fa2b58d0d6f7a801219c7794e26e.jpg%401280w_1l_2o_100sh.jpg",
            width: 100.0,
          ),
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            height: 50,
            width: 50.0,
            fit: BoxFit.contain,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.fitHeight,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.none,
          ),
          Image(
            image: img,
            width: 100.0,
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 200.0,
            repeat: ImageRepeat.repeatY,
          )
        ].map((e) {
          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 100,
                  child: e,
                ),
              ),
              Text(e.fit.toString())
            ],
          );
        }).toList()),
      ),
    );
  }
}
