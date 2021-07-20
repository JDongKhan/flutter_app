import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/get/get_normal_page.dart';
import 'package:get/get.dart';

/// @author jd

class NormalNextController extends GetxController {
  var counter = 0.obs;
  var counter2 = 2.obs;
  int get sum => counter.value + counter2.value;

  void increment() {
    counter++;
    counter2++;
  }

  @override
  void onClose() {
    print('NormalNextController onClose');
    super.onClose();
  }

  @override
  void onReady() {
    print('NormalNextController onReady');
    super.onReady();
  }

  @override
  void onInit() {
    print('NormalNextController onInit');
    super.onInit();
  }
}

class NormalNext2Controller extends GetxController {
  var counter = 0.obs;
  var counter2 = 2.obs;
  int get sum => counter.value + counter2.value;

  void increment() {
    counter++;
    counter2++;
  }

  @override
  void onClose() {
    print('NormalNextController onClose');
    super.onClose();
  }

  @override
  void onReady() {
    print('NormalNextController onReady');
    super.onReady();
  }

  @override
  void onInit() {
    print('NormalNextController onInit');
    super.onInit();
  }
}

class GetNormalNextPage extends StatefulWidget {
  @override
  _GetNormalNextPageState createState() => _GetNormalNextPageState();
}

class _GetNormalNextPageState extends State<GetNormalNextPage> {
  NormalNextController nextController = Get.put(NormalNextController());
  @override
  Widget build(BuildContext context) {
    Get.put(NormalNext2Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Next Page'),
      ),
      body: Column(
        children: [
          // GetX<NormalNext2Controller>(
          //   init: NormalNext2Controller(),
          //   builder: (NormalNext2Controller controller) {
          //     return Center(
          //       child: Text(
          //         'first: ${controller.counter}',
          //       ),
          //     );
          //   },
          // ),
          Obx(() => Text('${Get.find<NormalController>().sum}')),
          Obx(() => Text('${Get.find<NormalNextController>().sum}')),
          Obx(() => Text('${Get.find<NormalNext2Controller>().sum}')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<NormalController>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}

/**
class GetNormalNextPage extends StatelessWidget {
  NormalNextController nextController = Get.put(NormalNextController());
  @override
  Widget build(BuildContext context) {
    Get.put(NormalNext2Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Next Page'),
      ),
      body: Column(
        children: [
          // GetX<NormalNext2Controller>(
          //   init: NormalNext2Controller(),
          //   builder: (NormalNext2Controller controller) {
          //     return Center(
          //       child: Text(
          //         'first: ${controller.counter}',
          //       ),
          //     );
          //   },
          // ),
          Obx(() => Text('${Get.find<NormalController>().sum}')),
          Obx(() => Text('${Get.find<NormalNextController>().sum}')),
          Obx(() => Text('${Get.find<NormalNext2Controller>().sum}')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<NormalController>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
**/
