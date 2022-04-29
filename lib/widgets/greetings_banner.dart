import 'package:flutter/material.dart';

class GreetingBarner extends StatelessWidget {
  const GreetingBarner({Key? key, required this.dashboardKey})
      : super(key: key);
  final dashboardKey;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 5,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      shadowColor: Colors.black54,
      color: Colors.grey,
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  dashboardKey.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(),
                  title: const Text(
                    'Welcome Samuel',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  subtitle: const Text(
                    'Good morning',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color(0xFF796AF7),
                    ),
                  ),
                  trailing: Container(
                    width: 38,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.notifications_none_sharp),
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
