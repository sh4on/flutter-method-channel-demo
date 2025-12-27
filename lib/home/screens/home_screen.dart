import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text('Battery Level')),
      body: Obx(() {
        if (homeController.status.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeController.status.value.isError) {
          return Center(
            child: Text(
              homeController.status.value.errorMessage ??
                  "Something went wrong!",
            ),
          );
        } else {
          return Center(
            child: Text('Battery Level: ${homeController.batteryLevel.value}'),
          );
        }
      }),
    );
  }
}
