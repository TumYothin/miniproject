import 'package:firebasedemo/screens/showlist.dart';
import 'package:firebasedemo/screens/user_page.dart';
import 'package:flutter/material.dart';
import '../sevices/auth_seveice.dart';
import 'add_food items.dart';
import 'login.dart';

class navigationDrawer extends StatelessWidget {
  const navigationDrawer({Key? key}) : super(key: key);

  get padding => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 46, 117, 48),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  // const DrawerHeader(
                  //   child: Text('Food Allergy'),
                  // ),

                  ListTile(
                    leading: Icon(
                      Icons.add,
                    ),
                    iconColor: Color.fromARGB(255, 246, 240, 240),
                    title: const Text('AddFoodList',
                        style: TextStyle(
                            color: Color.fromARGB(255, 246, 240, 240))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addfooditems(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.food_bank_outlined),
                    iconColor: Color.fromARGB(255, 246, 240, 240),
                    title: const Text(
                      'ManageListFood',
                      style:
                          TextStyle(color: Color.fromARGB(255, 246, 240, 240)),
                    ),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => showlist(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    iconColor: Color.fromARGB(255, 246, 240, 240),
                    title: const Text('Logout',
                        style: TextStyle(
                            color: Color.fromARGB(255, 246, 240, 240))),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      googleSignOut().then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
