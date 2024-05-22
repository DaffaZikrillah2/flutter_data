import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/modules/Product/model/product.model.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

class EditProductController extends GetxController {
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController stok = TextEditingController();
  TextEditingController jenis = TextEditingController();

  FirebaseFirestore rs = FirebaseFirestore.instance;
  updateVariable(Product data) {
    nama.text = data.nama;
    harga.text = data.harga.toString();
    stok.text = data.stok.toString();
    jenis.text = data.jenis;
  }

  updateproduct(String id) async {
    CollectionReference product = rs.collection("product");
    final productData = {
      "nama": nama.text,
      "harga": int.parse(harga.text),
      "stok": int.parse(stok.text),
      "jenis": jenis.text
    };
    try {
      await product.doc(id).update(productData);
      Get.offAllNamed(Routes.PRODUCT);
    } catch (e) {
      Get.defaultDialog(middleText: 'Gagal Mengedit Product');
    }
  }
}
