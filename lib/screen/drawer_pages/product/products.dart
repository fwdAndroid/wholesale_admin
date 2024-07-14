import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/drawer_pages/product/add_products.dart';
import 'package:wholesale_admin/screen/drawer_pages/product/product_detail.dart';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No Product  Available",
                          style: TextStyle(color: black),
                        ),
                      );
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          final Map<String, dynamic> data =
                              documents[index].data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProductDetail(
                                            quantity:
                                                data['quantity'].toString(),
                                            description:
                                                data['productDescription'],
                                            serviceCategory: data['category'],
                                            uuid: data['uuid'],
                                            serviceDiscount:
                                                data['discountPrice']
                                                    .toString(),
                                            servicePrice:
                                                data['productPrice'].toString(),
                                            serviceImage: data['productImages'],
                                            serviceName: data['productName'],
                                            serviceSubCateory:
                                                data['subCategory'],
                                          )));
                            },
                            child: SizedBox(
                              height: 72,
                              width: 72,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        data['productImages'],
                                      ),
                                    ),
                                  ),
                                  Text(data['productName'])
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
