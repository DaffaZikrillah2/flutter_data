// ignore_for_file: avoid_print, unused_local_variable, unnecessary_overrides, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  String codeOtp = "";

  Stream authStatus = FirebaseAuth.instance.authStateChanges();

  login(String email, String password) async {
    try {
      // ignore: prefer_const_constructors
      Get.defaultDialog(content: CircularProgressIndicator(), title: "loading");
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          middleText: 'Email Terkirim! Silahkan Cek Email Anda',
          confirm: ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.LOGIN),
              // ignore: prefer_const_constructors
              child: Text('Ok')));
    } catch (e) {
      Get.defaultDialog(
          middleText: "Gagal Mengirim Email",
          // ignore: prefer_const_constructors
          confirm: ElevatedButton(onPressed: () {}, child: Text('Ok')));
    }
  }

  sendOtp(String nomer) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+62$nomer',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Get.toNamed(Routes.HOME);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.defaultDialog(middleText: "Gagal Mengirim OTP!");
        },
        codeSent: (String verificationId, int? resendToken) {
          codeOtp = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          codeOtp = verificationId;
        },
        // ignore: prefer_const_constructors
        timeout: Duration(seconds: 60));
    Get.offAllNamed(Routes.OTP);
  }

  // ignore: non_constant_identifier_names
  register(String email, String password, String KonfirmasiPassword) async {
    try {
      // ignore: prefer_const_constructors
      Get.defaultDialog(content: CircularProgressIndicator(), title: "loading");
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
        // KonfirmasiPassword: KonfirmasiPassword
      );
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      try {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.defaultDialog(middleText: "Gagal Login Google", title: "Error");
      }
    }
  }

  checkOtp(String codeSms) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: codeOtp, smsCode: codeSms))
          .then((value) {
        if (value.user != null) {
          Get.toNamed(Routes.HOME);
        }
      });
    } catch (e) {
      Get.defaultDialog(middleText: 'Code otp salah!');
    }
  }
}
