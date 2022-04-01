import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../sevices/auth_seveice.dart';
import '../util/places.dart';
import '../widgets/horizontol_place.item.dart';
import '../widgets/search_bar.dart';
import '../widgets/vertical_place_item.dart';
import 'login.dart';
import 'navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: navigationDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // googleSignOut().then((value) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const LoginPage(),
              //     ),
              //   );
              // });
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/logo2.png',
              width: 90,
            ),
            // Text(
            //   "โรคภูมิเเพ้สารอาหาร \nFood Allergy",
            //   style: TextStyle(
            //       fontSize: 30.0,
            //       fontWeight: FontWeight.w600,
            //       color: Color.fromARGB(255, 4, 88, 6)),
            // ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(),
          ),
          buildHorizontalList(context),
        ],
      ),
    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
