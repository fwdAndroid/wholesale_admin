import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/utils/colors.dart';

class ProductDetail extends StatefulWidget {
  final uuid;
  final description;
  final quantity;
  final serviceCategory;
  final serviceSubCateory;
  final serviceDiscount;
  final serviceImage;
  final serviceName;
  final servicePrice;
  const ProductDetail(
      {super.key,
      required this.description,
      required this.serviceSubCateory,
      required this.quantity,
      required this.serviceCategory,
      required this.serviceDiscount,
      required this.serviceImage,
      required this.serviceName,
      required this.servicePrice,
      required this.uuid});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.serviceImage,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: colorWhite,
                        )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                widget.serviceName,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.servicePrice.toString(),
                    style: TextStyle(
                        color: Color(0xff156778),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    width: 100,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/pricetag.png",
                          width: 16,
                          height: 16,
                        ),
                        Text(
                          widget.serviceDiscount.toString() + "%",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffFFF9E5),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Divider(
                color: primary.withOpacity(.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "About Product",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: black),
              ),
            ),
            SizedBox(
              width: 343,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary, fixedSize: Size(200, 50)),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Alert'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Do you want to delete the product'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(widget.uuid)
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: colorWhite),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
