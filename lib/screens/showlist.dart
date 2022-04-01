import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_food items.dart';
import 'editlist.dart';

class showlist extends StatefulWidget {
  const showlist({Key? key}) : super(key: key);

  @override
  State<showlist> createState() => _showlistState();
}

class _showlistState extends State<showlist> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text('${user.email}'),
            // Text('${user.uid}'),
            showList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Move to Add Product Page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const addfooditems(),
                )).then((value) => setState(() {}));
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget showList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('listfood')
          .where('uid', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        List<Widget> myList;

        if (snapshot.hasData) {
          // Convert snapshot.data to jsonString
          var products = snapshot.data;

          // Define Widgets to myList
          myList = [
            Column(
              children: products!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ListTile(
                          onTap: () {
                            // Navigate to Edit Product

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      editfoodlist(id: doc.id),
                                )).then((value) => setState(() {}));
                          },
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Icon(Icons.food_bank,
                                color: Color.fromARGB(255, 46, 117, 48)),
                          ),
                          title: Text('\t\t${data['foodname']}'),
                          subtitle: Text(
                              '\t\tวันที่ : ${data['date']}\n\t\tเวลา : ${data['time']}'),
                          trailing: IconButton(
                            onPressed: () {
                              // Create Alert Dialog
                              var alertDialog = AlertDialog(
                                title:
                                    const Text('Delete Product Confirmation'),
                                content: Text(
                                    'คุณต้องการลบลิตส์ ${data['foodname']} ใช่หรือไม่'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ยกเลิก')),
                                  TextButton(
                                      onPressed: () {
                                        var alertDelete = AlertDialog(
                                          title: const Text('Delete success'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('ยืนยัน')),
                                          ],
                                        );
                                        deleteListFood(doc.id);
                                      },
                                      child: const Text('ยืนยัน')),
                                ],
                              );
                              // Show Alert Dialog
                              showDialog(
                                  context: context,
                                  builder: (context) => alertDialog);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ];
        } else if (snapshot.hasError) {
          myList = [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('ข้อผิดพลาด: ${snapshot.error}'),
            ),
          ];
        } else {
          myList = [
            const SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('อยู่ระหว่างประมวลผล'),
            )
          ];
        }

        return Center(
          child: Column(
            children: myList,
          ),
        );
      },
    );
  }

  Future<void> deleteListFood(String? id) {
    return FirebaseFirestore.instance
        .collection('listfood')
        .doc(id)
        .delete()
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
