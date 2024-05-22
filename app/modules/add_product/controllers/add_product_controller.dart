// ignore_for_file: unnecessary_overrides, empty_catches, prefer_const_constructors, unused_import

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';
import 'package:file_picker/file_picker.dart';

class AddProductController extends GetxController {
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController jenis = TextEditingController();

  FirebaseFirestore rs = FirebaseFirestore.instance;
  RxString url = "".obs;
  FirebaseStorage storage = FirebaseStorage.instance;

  saveProduct() async {
    CollectionReference product = rs.collection("product");
    final productData = {
      "nama": nama.text,
      "harga": int.parse(harga.text),
      "stok": int.parse(stok.text),
      "jenis": jenis.text
    };
    try {
      await product.add(productData).then((value) {
        Get.defaultDialog(
            middleText: 'Berhasil Menambahkan Product',
            confirm: ElevatedButton(onPressed: () {}, child: Text('Ok')));
      });
      Get.offAllNamed(Routes.PRODUCT);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Menambahkan Product');
    }
  }

  uploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String fileName = result.files.first.name;
      try {
        await storage.ref('product/$fileName').putData(fileBytes!);

        final dataUrl = storage.ref('product/$fileName').getDownloadURL();

        url.value = await dataUrl;
      } catch (e) {
        Get.defaultDialog(middleText: "Gagal Mengupload File");
      }
    }
  }
}
