// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/authcontroller_controller.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
    final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body:  Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
               controller: controller.email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              controller: controller.password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
             TextField(
              obscureText: true,
                controller: controller.KonfirmasiPassword,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(),
              ),
               onSubmitted: (value) =>
                  auth.register (controller.email.text, controller.password.text, controller.KonfirmasiPassword.text),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk membuat akun dengan Google
              },
              child: Text('Sign Up with Google'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk membuat akun dengan nomor telepon
              },
              child: Text('Sign Up with Phone'),
            ),
          ],
        ),
      ),
    );
  }
}