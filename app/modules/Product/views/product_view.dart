// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_firebase/app/controllers/authcontroller_controller.dart';
import 'package:latihan_firebase/app/modules/Product/model/product.model.dart';
import 'package:latihan_firebase/app/routes/app_pages.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  ProductView({Key? key}) : super(key: key);

  final srt = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProductView'),
          centerTitle: true,
        ),
        body: Obx(() => controller.status.value
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('Harga')),
                      DataColumn(label: Text('Stok')),
                      // DataColumn(label: Text('Jenis')),
                    ],
                    rows: List.generate(controller.data.length, (index) {
                      var nomer = index + 1;
                      Product dt = controller.data[index];
                      return DataRow(cells: [
                        DataCell(Text('$nomer')),
                        DataCell(Text(dt.nama)),
                        DataCell(Text(dt.stok.toString())),
                        // DataCell(Text('2000')),
                        DataCell(Row(
                          children: [
                            IconButton(
                              onPressed: () => Get.toNamed(Routes.EDIT_PRODUCT, arguments: dt),
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        )),
                      ]);
                    })),
              )
            : Center(
                child: CircularProgressIndicator(),   
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ));
  }
}
