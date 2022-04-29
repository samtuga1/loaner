import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(17.0),
          child: CircleAvatar(
            radius: 65,
          ),
        ),
        Positioned(
          right: 15,
          top: 106,
          child: GestureDetector(
            onTap: () {
              print('select image');
            },
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
