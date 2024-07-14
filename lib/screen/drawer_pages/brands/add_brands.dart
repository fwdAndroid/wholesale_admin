import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wholesale_admin/services/storage.dart';
import 'package:wholesale_admin/utils/colors.dart';
import 'package:wholesale_admin/utils/pick_image.dart';
import 'package:wholesale_admin/widgets/buttons.dart';
import 'package:wholesale_admin/widgets/input_text.dart';

class AddBrands extends StatefulWidget {
  const AddBrands({super.key});

  @override
  State<AddBrands> createState() => _AddBrandsState();
}

class _AddBrandsState extends State<AddBrands> {
  //Image
  Uint8List? _image;
  var uuid = Uuid().v4();
  bool isLoading = false;
  TextEditingController brandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        centerTitle: true,
        title: Text(
          "Add Brands",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Brand Photo",
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16, color: black),
              ),
            ),
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
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Add Name",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputText(
                controller: brandController,
                labelText: "Brand Name",
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {},
                onSaved: (val) {},
                textInputAction: TextInputAction.done,
                isPassword: false,
                enabled: true,
              ),
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
                        "Add Brand",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      onPressed: () async {
                        if (_image == null || brandController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Images and Brand Name is Required")));
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          String promotionImage =
                              await StorageMethods().uploadImageToStorage(
                            'ProfilePics',
                            _image!,
                          );

                          await FirebaseFirestore.instance
                              .collection("brands")
                              .doc("uuid")
                              .set({
                            "image": promotionImage,
                            "uuid": uuid,
                            "brandName": brandController.text
                          });
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Brands are Added")));
                          Navigator.pop(context);
                        }
                      },
                    ),
            )
          ],
        ),
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
