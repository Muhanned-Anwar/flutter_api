import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/get/images_getx_controller.dart';
import 'package:flutter_api/models/student_image.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  double? _progressValue = 0;
  late ImagePicker _imagePicker;
  XFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progressValue,
            color: Colors.blue.shade500,
            backgroundColor: Colors.grey.shade400,
            minHeight: 5,
          ),
          Expanded(
            child: _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : TextButton(
                    onPressed: () async => await pickImage(),
                    child: Text('Select Image'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      minimumSize: Size(double.infinity, 0),
                    ),
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () async => await uploadImage(),
            icon: Icon(Icons.cloud_upload),
            label: Text('Upload Image'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    _imagePicker = ImagePicker();
    XFile? selectedImageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImageFile != null) {
      setState(() {
        _pickedFile = selectedImageFile;
      });
    }
  }

  Future uploadImage() async {
    _changeProgressValue(value: null);
    if (_pickedFile != null) {
      ImagesGetxController.to.upload(
        filePath: _pickedFile!.path,
        imageUploadResponse: ({
          required String message,
          required bool status,
          StudentImage? studentImage,
        }) {
          _changeProgressValue(value: status ? 1 : 0);
          // if(status) clearSelectedImage();
        },
      );
    }
  }

  void _changeProgressValue({required double? value}){
    setState(() {
      _progressValue = value;
    });
  }

  void clearSelectedImage(){
    setState(() {
      _pickedFile = null;
    });
  }
}
