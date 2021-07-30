import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_normal_next_page.dart';

/// @author jd

class NormalController extends GetxController {
  var counter = 0.obs;
  var counter2 = 2.obs;
  int get sum => counter.value + counter2.value;

  void increment() {
    counter++;
    counter2++;
  }
}

class GetNormalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('GetNormalPage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get NormalPage'),
        actions: [
          TextButton(
            onPressed: () {
              // Get.to(() => GetNormalNextPage());
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GetNormalNextPage(),
                ),
              );
            },
            child: Text('Next'),
          ),
        ],
      ),
      body: Column(
        children: [
          GetX<NormalController>(
            init: NormalController(),
            builder: (NormalController controller) {
              return Center(
                child: Text(
                  'first: ${controller.counter}',
                ),
              );
            },
          ),
          Obx(
            () => Center(
              child: Text('sencond: ${Get.find<NormalController>().counter2}'),
            ),
          ),
          Obx(
            () => Center(
              child: Text('sum: ${Get.find<NormalController>().sum}'),
            ),
          ),
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
