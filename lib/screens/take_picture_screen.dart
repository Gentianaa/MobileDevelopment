
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required Iterable<CameraDescription> cameras}) : super(key: key);

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Picture page")),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
             ElevatedButton(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.camera);
                setState(() {
                });
              },
              child: const Text("Take a picture with camera"),
            ),
            ElevatedButton(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                });
              },
              child: const Text("Pick image from gallery"),
            ),
          image == null?Container():
              Image.file(File(image!.path))
      ],)
      )
    );
  }
}