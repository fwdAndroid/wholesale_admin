import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/drawer_pages/product/add_products.dart';
import 'package:wholesale_admin/utils/colors.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        centerTitle: true,
        title: Text(
          "Products",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: primary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddProducts()));
        },
        child: Icon(
          Icons.add,
          color: colorWhite,
        ),
      ),
    );
  }
}
