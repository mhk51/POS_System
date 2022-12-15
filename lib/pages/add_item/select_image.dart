import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/item_builder.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? pickedImage;
  Future getImage(ImageSource imageSource, ItemBuilder item) async {
    XFile? tempStore = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      pickedImage = File(tempStore!.path);
    });
    item.updateImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    ItemBuilder item = Provider.of<ItemBuilder>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          width: 150,
          height: 150,
          child: Center(
            child: pickedImage == null
                ? Icon(
                    Icons.photo,
                    size: 40,
                    color: Colors.grey[700],
                  )
                : Image.file(
                    pickedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              onPressed: () async {
                await getImage(ImageSource.gallery, item);
              },
              icon: const Icon(Icons.folder),
              label: const Text('CHOOSE PHOTO'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              onPressed: () async {
                await getImage(ImageSource.camera, item);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('TAKE PHOTO'),
            )
          ],
        ),
      ],
    );
  }
}
