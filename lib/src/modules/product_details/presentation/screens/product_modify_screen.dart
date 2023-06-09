import 'dart:io';

import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/product_details/presentation/screens/upload_page.dart';
import 'package:ecommercebusiness/src/modules/product_details/presentation/viewmodel/modify_product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductModifyScreen extends StatefulWidget {
  final String? id;
  final String type;
  const ProductModifyScreen({
    super.key,
    this.id,
    required this.type,
  });

  @override
  State<ProductModifyScreen> createState() => _ProductModifyScreenState();
}

class _ProductModifyScreenState extends State<ProductModifyScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? imagePath;
  TextEditingController categoryController = TextEditingController();
  List<String> categories = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  var selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: buildColumnModifyProduct(context),
      ),
    );
  }

  Column buildColumnModifyProduct(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTextField('title', titleController),
        15.ph,
        buildTextField('price', priceController),
        15.ph,
        buildTextField('description', descriptionController),
        15.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            imagePath != null
                ? Image.file(
                    imagePath!,
                    height: 100,
                    fit: BoxFit.contain,
                  )
                : const SizedBox(),
            TextButton.icon(
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => const UploadImagePage(),
                  ))
                      .then((value) {
                    setState(() {
                      imagePath = value;
                    });
                  });

                  debugPrint(imagePath.toString());
                },
                icon: const Icon(Icons.camera),
                label: const TextWidget(txt: 'Upload Image')),
          ],
        ),
        15.ph,
        buildDropdownButtonCategories(),
        10.ph,
        Consumer(builder: (context, ref, child) {
          final modify = ref.watch(modifyProduct);
          return ElevatedButton(
              onPressed: () async {
                modifyFunc(modify);
              },
              child: TextWidget(
                txt: '${widget.type.capitalize()} Product',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ));
        })
      ],
    );
  }

  DropdownButton<String> buildDropdownButtonCategories() {
    return DropdownButton<String>(
      value: selectedCategory,
      hint: const TextWidget(txt: 'Choose Category'),
      borderRadius: BorderRadius.circular(15),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category.capitalize()),
        );
      }).toList(),
      onChanged: (newValue) {
        // Handle the selection change
        setState(() {
          selectedCategory = newValue;
        });
      },
    );
  }

  TextField buildTextField(String title, TextEditingController controller) =>
      TextField(
          controller: controller,
          decoration: InputDecoration(
              filled: true, fillColor: AppColor.white, hintText: title));

  void modifyFunc(ModifyProductRiverpod modify) {
    if (widget.type == 'update') {
      modify
          .updateProduct(
              id: widget.id.toString(),
              title: titleController.text,
              price: double.parse(priceController.text),
              description: descriptionController.text,
              imagePath: imagePath,
              category: selectedCategory)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.primaryBLue,
            behavior: SnackBarBehavior.floating,
            content: TextWidget(
              txt:
                  'Success updated new product \ntitle: ${value['title']},\nprice: \$${value['price']},\ncategory: ${value['category']}',
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )));
        Navigator.pop(context);
      });
    } else {
      modify
          .createProduct(
              id: widget.id.toString(),
              title: titleController.text,
              price: double.parse(priceController.text),
              description: descriptionController.text,
              imagePath: imagePath,
              category: selectedCategory)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.primaryBLue,
            behavior: SnackBarBehavior.floating,
            content: TextWidget(
              txt:
                  'Success created new product \ntitle: ${value['title']},\nprice: \$${value['price']},\ncategory: ${value['category']}',
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )));
      }).catchError((error) {
        debugPrint(error.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: TextWidget(txt: 'Failed $error')));
      });
    }
    debugPrint({
      'title': titleController.text,
      'price': double.parse(priceController.text),
      'description': descriptionController.text,
      'image': imagePath,
      'category': categoryController.text,
    }.toString());
  }
}
