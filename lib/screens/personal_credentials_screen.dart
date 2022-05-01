import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Step personalCredentialsScreen(int _currentStep) {
  return Step(
    isActive: _currentStep >= 1,
    title: const Text('Bank Details'),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Passbook Photo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        UploadCredentials(type: 'Capture Passbook'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Salary Slip',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        UploadCredentials(type: 'Capture Slip'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Account Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 25, left: 20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.document_scanner_outlined,
                      size: 26,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text('Account Number'),
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.document_scanner_outlined,
                      size: 26,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Text('Bank Name'),
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ignore: must_be_immutable
class UploadCredentials extends StatefulWidget {
  UploadCredentials({
    Key? key,
    required this.type,
  }) : super(key: key);
  String type;
  @override
  State<UploadCredentials> createState() => _UploadCredentialsState();
}

class _UploadCredentialsState extends State<UploadCredentials> {
  Future<void> pickImage() async {
    final filePicker = ImagePicker();
    final pickedImageFile = await filePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    if (pickedImageFile == null) {
      return;
    }
    String imageName = pickedImageFile.name;
    setState(() {
      widget.type = imageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100, minHeight: 60),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.cloud_download_outlined),
        title: Text(
          widget.type,
          style: const TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: pickImage,
          icon: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
