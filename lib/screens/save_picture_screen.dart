import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class SavePictureScreen extends StatefulWidget {
  @override
  _SavePictureScreenState createState() => _SavePictureScreenState();
}

class _SavePictureScreenState extends State<SavePictureScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _takePicture() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<void> _saveImage() async {
    Directory? directory = await getExternalStorageDirectory();
    String imagePath = "${directory!.path}/gallery";

    File(_image!.path).copy(imagePath);

    // If you want to delete the original image from cache.
    File(_image!.path).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Image.file(File(_image!.path))
            else
              Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePicture,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null ? _saveImage : null,
              child: Text('Save Image'),
            ),
          ],
        ),
      ),
    );
  }
}