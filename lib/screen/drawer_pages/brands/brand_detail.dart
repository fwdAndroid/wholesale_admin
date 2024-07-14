import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/utils/colors.dart';

class BrandDetail extends StatefulWidget {
  final providerName;
  final serviceImage;
  final uuid;
  BrandDetail({
    super.key,
    required this.providerName,
    required this.serviceImage,
    required this.uuid,
  });

  @override
  State<BrandDetail> createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        centerTitle: true,
        title: Text(
          "Brand Detail",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.serviceImage),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                widget.providerName,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: black),
              ),
            ),
          ),
          Padding(
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
                              Text('Do you want to delete the brand'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Approve'),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("brands")
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
          )
        ],
      ),
    );
  }
}
