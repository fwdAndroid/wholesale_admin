import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wholesale_admin/services/storage.dart';
import 'package:wholesale_admin/utils/colors.dart';
import 'package:wholesale_admin/utils/pick_image.dart';
import 'package:wholesale_admin/widgets/buttons.dart';

class AddPromotionImages extends StatefulWidget {
  const AddPromotionImages({super.key});

  @override
  State<AddPromotionImages> createState() => _AddPromotionImagesState();
}

class _AddPromotionImagesState extends State<AddPromotionImages> {
  //Image
  Uint8List? _image;
  var uuid = Uuid().v4();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        centerTitle: true,
        title: Text(
          "Add Promotions",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () => selectImage(),
                child: _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : Image.asset("assets/frame.png")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : WonsButton(
                    height: 50,
                    width: 348,
                    verticalPadding: 0,
                    color: primary,
                    child: const Text(
                      "Add Promotion Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String promotionImage =
                          await StorageMethods().uploadImageToStorage(
                        'ProfilePics',
                        _image!,
                      );

                      await FirebaseFirestore.instance
                          .collection("promotionsImages")
                          .doc(uuid)
                          .set({"image": promotionImage, "uuid": uuid});
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Promotions Images are Added")));
                      Navigator.pop(context);
                    },
                  ),
          )
        ],
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
