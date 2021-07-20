import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleController extends GetxController {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    update(['counter']);
  }

  @override
  void onClose() {
    print('onClose');
    super.onClose();
  }

  @override
  void onReady() {
    print('onReady');
    super.onReady();
  }

  @override
  void onInit() {
    print('onInit');
    super.onInit();
  }
}

/// @author jd
class GetSimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('GetSimplePage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get SimplePage'),
      ),
      body: GetBuilder<SimpleController>(
        id: 'counter',
        init: SimpleController(),
        builder: (SimpleController controller) {
          return Center(
            child: Text(
              controller.counter.toString(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<SimpleController>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
