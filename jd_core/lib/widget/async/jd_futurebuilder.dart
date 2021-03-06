import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 *
 * @author jd
 *
 */


typedef JDFutureCallback<T> = Widget Function(BuildContext context, dynamic data);

class JDFutureBuilder<T> extends FutureBuilder<T> {

  JDFutureBuilder({
    Key key,
    this.future,
    this.initialData,
    this.loading,
    this.complete,
    this.error,
    this.onError,
  }):super(
      key:key,
      future:future,
      initialData:initialData,
      builder:(BuildContext context,AsyncSnapshot<T> snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (error != null) {
              return error(context, snapshot.error);
            } else {
              return InkWell(
                    onTap: (){
                      if(onError != null) {
                        onError();
                      }
                    },
                    child: Container(alignment: Alignment.center, child: const Text('网络请求失败，点击刷新')),
                  );
            }
          } else if (complete != null) {
            return complete(context, snapshot.data);
          }
        }
        if (loading != null) {
          return Center(
            child: loading,
          );
        }
        return Center(
          child:  SpinKitWave(
            color: Colors.red[100],
            size: 50.0,
//            controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
          ),
        );
      });


  final Widget loading;

  final JDFutureCallback<T> complete;

  final JDFutureCallback<T> error;

  final Function onError;

  final Future<T> future;

  final T initialData;
}
