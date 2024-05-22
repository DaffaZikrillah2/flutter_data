// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/authcontroller_controller.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => Get.offAllNamed(Routes.PRODUCT),
            child: Text("Go Product"),
          ),
          Center(
            child: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Are u sure',
                    middleText: 'logout this apk?',
                    confirm: ElevatedButton(
                        onPressed: () => auth.logout(),
                        child: Text(
                          'yess',
                          style: TextStyle(color: Colors.white),
                        )),
                    cancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () => Get.back(),
                        child: Text('no')),
                  );
                },
                icon: Icon(Icons.logout)),
          ),
        ],
      ),
    );
  }
}
