// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/authcontroller_controller.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller.email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: controller.password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) =>
                  auth.login(controller.email.text, controller.password.text),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => Get.offAllNamed(Routes.LUPAPASSWORD),
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Fungsi untuk menangani tombol belum punya akun
                  },
                  child: Text(
                    'Belum Punya Akun?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                auth.login(controller.email.text, controller.password.text);
                // Fungsi untuk login dengan email
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign in with Email',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () => auth.signInWithGoogle(),
              // Fungsi untuk login dengan Google

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.PHONE);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign in with Phone',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
