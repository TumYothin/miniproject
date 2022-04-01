import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class editfoodlist extends StatefulWidget {
  const editfoodlist({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<editfoodlist> createState() => _editfoodlistState();
}

class _editfoodlistState extends State<editfoodlist> {
  final user = FirebaseAuth.instance.currentUser!;
  final _editFormKey = GlobalKey<FormState>();
  final TextEditingController _dateinput = TextEditingController();
  final TextEditingController _foodname = TextEditingController();
  final TextEditingController _timeinput = TextEditingController();

  @override
  void initState() {
    super.initState();
    //สร้าง function ตอนเริ่มต้น สำหรับดึงข้อมูล
    getdata();
  }

  Future<void> getdata() async {
    FirebaseFirestore.instance
        .collection('listfood')
        .doc(widget.id.toString())
        .get()
        .then((DocumentSnapshot value) {
      Map<String, dynamic> data = value.data()! as Map<String, dynamic>;
      _foodname.text = data["foodname"];
      _dateinput.text = data['date'];
      _timeinput.text = data['time'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update ListFood'),
      ),
      body: Form(
        key: _editFormKey,
        child: mainInput(),
      ),
    );
  }

  Widget mainInput() {
    return Container(
      child: ListView(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 70,
          ),
          inputDate(),
          inputTime(),
          inputfoodname(),
          updateButton(),
        ],
      ),
    );
  }

  Widget updateButton() {
    return Container(
      width: 150,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
        onPressed: updatefoodlist,
        child: const Text('บันทึกข้อมูล'),
      ),
    );
  }

  Future<void> updatefoodlist() async {
    return FirebaseFirestore.instance
        .collection('listfood')
        .doc(widget.id.toString())
        .update({
          'foodname': _foodname.text,
          'time': _timeinput.text,
          'date': _dateinput.text,
          'uid': user.uid
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Container inputDate() {
    return Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: TextFormField(
          controller: _dateinput, //editing controller of this TextField
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 21, 87, 23), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.lightGreen, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Color.fromARGB(255, 21, 87, 23),
            ),
            label: Text(
              'Enter Date',
              style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
            ),
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(
                    2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                _dateinput.text = formattedDate;
                //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        ));
  }

  Container inputTime() {
    return Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: TextFormField(
          controller: _timeinput, //editing controller of this TextField
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 21, 87, 23), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.lightGreen, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            prefixIcon: Icon(
              Icons.access_time,
              color: Color.fromARGB(255, 21, 87, 23),
            ),
            label: Text(
              'Enter Time',
              style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
            ),
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );
            if (pickedTime != null) {
              print(pickedTime.format(context)); //output 10:51 PM
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              //converting to DateTime so that we can further format on different pattern.
              print(parsedTime); //output 1970-01-01 22:53:00.000
              String formattedTime = DateFormat('HH:mm').format(parsedTime);
              print(formattedTime); //output 14:59:00
              //DateFormat() is from intl package, you can format the time on any pattern you need.

              setState(() {
                _timeinput.text = formattedTime; //set the value of text field.
              });
            } else {
              print("Time is not selected");
            }
          },
        ));
  }

  Container inputfoodname() {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: TextFormField(
        controller: _foodname,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Your foodname';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 21, 87, 23), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.lightGreen, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: Icon(
            Icons.food_bank,
            color: Color.fromARGB(255, 21, 87, 23),
          ),
          label: Text(
            'Foodname',
            style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
          ),
        ),
      ),
    );
  }
}
