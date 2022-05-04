import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GreetingBarner extends StatelessWidget {
  const GreetingBarner({Key? key, this.drawerKey}) : super(key: key);
  final dynamic drawerKey;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance
          .ref('user_images')
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg')
          .getDownloadURL(),
      builder: (context, snapshot) => PhysicalModel(
        elevation: 5,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        shadowColor: Colors.black54,
        color: Colors.grey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.topCenter,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    drawerKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage(
                        snapshot.connectionState == ConnectionState.waiting
                            ? 'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg'
                            : snapshot.data.toString(),
                      ),
                    ),
                    title: const Text(
                      'Welcome Samuel!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Good morning!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Container(
                      width: 38,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications_none_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
