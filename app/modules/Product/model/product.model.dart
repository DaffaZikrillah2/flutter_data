// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str, String id) =>
    Product.fromJson(json.decode(str), id);

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String nama;
  int harga;
  int stok;
  String jenis;
  String id;

  Product({
    required this.nama,
    required this.harga,
    required this.stok,
    required this.jenis,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json, String id) => Product(
        nama: json["nama"],
        harga: json["harga"],
        stok: json["stok"],
        jenis: json["jenis"],
        id: id,
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "stok": stok,
        "jenis": jenis,
        "id": id,
      };
}
