import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  File? _pickedImage;

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _pickedImage = File(imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(17.0),
          child: CircleAvatar(
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null,
            radius: 65,
          ),
        ),
        Positioned(
          right: 15,
          top: 106,
          child: GestureDetector(
            onTap: selectImage,
            child: Container(
              child: const Center(
                child: Icon(Icons.edit),
              ),
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
