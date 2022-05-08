import 'package:flutter/material.dart';
import 'package:loaner/providers/greeting_card.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class GreetingBarner extends StatelessWidget {
  const GreetingBarner({Key? key, this.drawerKey}) : super(key: key);
  final dynamic drawerKey;

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
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
              Expanded(
                child: ListTile(
                  leading: const ProfilePhotoContainer(),
                  title: const Username(),
                  subtitle: Text(
                    getGreeting(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ), //GetTime(),
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
    );
  }
}

class ProfilePhotoContainer extends StatelessWidget {
  const ProfilePhotoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProfilePicture>(context, listen: false)
          .getProfilePicture(),
      builder: (context, snapshot) => Consumer<ProfilePicture>(
        builder: (context, photo, _) => CircleAvatar(
          radius: 24,
          backgroundImage: snapshot.connectionState == ConnectionState.waiting
              ? const NetworkImage(
                  'https://monstar-lab.com/global/wp-content/uploads/sites/11/2019/04/male-placeholder-image.jpeg',
                )
              : NetworkImage(photo.profilePicture!),
        ),
      ),
    );
  }
}

class Username extends StatelessWidget {
  const Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? username =
        Provider.of<Users>(context, listen: false).username;
    return FutureBuilder(
      future: Provider.of<Users>(context).getUsername(),
      builder: (context, snapshot) => Text(
        snapshot.connectionState == ConnectionState.waiting
            ? 'Welcome !'
            : 'Welcome $username!',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
