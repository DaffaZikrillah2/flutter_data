import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latihan_firebase/app/modules/Product/model/product.model.dart';

class ProductController extends GetxController {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  RxBool status = false.obs;
  List<Product> data = [];
  getProduct() async {
    final product = await fs.collection("product").get();

    if (product.docs.isNotEmpty) {
      print(product.docs);
      product.docs.map((e) {
        print(e.data());
        print(e.id);
        Product productList = Product.fromJson(Map.from(e.data()), e.id);
        data.add(productList);
      }).toList();
      status.value = true;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
