import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wholesale_admin/screen/model/category_model.dart';
import 'package:wholesale_admin/services/storage.dart';
import 'package:wholesale_admin/utils/colors.dart';
import 'package:wholesale_admin/utils/pick_image.dart';
import 'package:wholesale_admin/widgets/input_text.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String? selectedCategory;
  String? selectedSubcategory;
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qController = TextEditingController();
  // Image
  Uint8List? _image;

  // Loading bar
  bool isAdded = false;

  // Error message for discount
  String? discountErrorMessage;

  @override
  void initState() {
    super.initState();
    discountController.addListener(_validateDiscount);
  }

  @override
  void dispose() {
    discountController.removeListener(_validateDiscount);
    super.dispose();
  }

  void _validateDiscount() {
    final input = discountController.text;
    if (input.isNotEmpty) {
      final value = int.tryParse(input);
      setState(() {
        discountErrorMessage = (value != null && value > 100)
            ? 'Discount cannot be more than 100%'
            : null;
      });
    } else {
      setState(() {
        discountErrorMessage = null;
      });
    }
  }

  var uuid = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorWhite),
        centerTitle: true,
        title: Text(
          "Add Products",
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => selectImage(),
              child: _image != null
                  ? CircleAvatar(
                      radius: 59, backgroundImage: MemoryImage(_image!))
                  : GestureDetector(
                      onTap: () => selectImage(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/frame.png"),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: InputText(
                controller: serviceNameController,
                labelText: "Product Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select Category'),
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    selectedSubcategory =
                        null; // Reset subcategory when category changes
                  });
                },
              ),
            ),
            if (selectedCategory != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Select Subcategory'),
                  value: selectedSubcategory,
                  items: categories
                      .firstWhere(
                          (category) => category.name == selectedCategory)
                      .subcategories
                      .map((subcategory) {
                    return DropdownMenuItem<String>(
                      value: subcategory,
                      child: Text(subcategory),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubcategory = value;
                    });
                  },
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: InputText(
                      controller: priceController,
                      labelText: "Price",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputText(
                          controller: discountController,
                          labelText: "Discount",
                        ),
                        if (discountErrorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Text(
                              discountErrorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputText(
                controller: qController,
                labelText: "Quantity",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLength: 30,
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Color(0xffF6F7F9),
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isAdded
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          fixedSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        "Save",
                        style: TextStyle(color: colorWhite),
                      ),
                      onPressed: () async {
                        if (_image == null) {
                          showMessageBar("Image is Required", context);
                        } else if (serviceNameController.text.isEmpty) {
                          showMessageBar("Product Name is Required", context);
                        } else if (priceController.text.isEmpty) {
                          showMessageBar("Price is Required", context);
                        } else if (descriptionController.text.isEmpty) {
                          showMessageBar("Description is Required", context);
                        } else {
                          int discount = 0;
                          if (discountController.text.isNotEmpty) {
                            discount =
                                int.tryParse(discountController.text) ?? 0;
                            if (discount > 100) {
                              showMessageBar(
                                  "Discount cannot be more than 100%", context);
                              return;
                            }
                          }

                          setState(() {
                            isAdded = true;
                          });
                          String productImages =
                              await StorageMethods().uploadImageToStorage(
                            'ProfilePics',
                            _image!,
                          );

                          await FirebaseFirestore.instance
                              .collection("products")
                              .doc(uuid)
                              .set({
                            "productName": serviceNameController.text,
                            "productDescription": descriptionController.text,
                            "productPrice": int.parse(priceController.text),
                            "discountPrice": int.parse(discountController.text),
                            "category": selectedCategory,
                            "subCategory": selectedSubcategory,
                            "productImages": productImages,
                            "quantity": int.parse(qController.text)
                          });
                          setState(() {
                            isAdded = false;
                          });
                          // Handle the result accordingly

                          showMessageBar("Product Added Successfully", context);
                          Navigator.pop(context);
                        }
                      }),
            ),
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

  void showMessageBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
