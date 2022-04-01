import 'package:firebasedemo/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

import '../sevices/auth_seveice.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            child: ListView(children: [
              // Image.asset('assets/image.png'),
              Image.asset(
                'assets/logo.png',
                width: 70,
              ),
              inputEmail(),
              inputPassword(),
              formButton(),
            ]),
          ),
        ),
      ),
    );
  }

  Container formButton() {
    double width = 130;
    double height = 45;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          loginButton(width, height),
          registerButton(width, height),
        ],
      ),
    );
  }

  SizedBox registerButton(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ),
          );
        },
        child: const Text(
          'Sing Up',
          style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
        ),
      ),
    );
  }

  SizedBox loginButton(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              loginUser(_email.text, _password.text).then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              });
            }
          },
          child: const Text('Sing in')),
    );
  }

  Container inputEmail() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
      child: TextFormField(
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Your E-mail';
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
            Icons.email,
            color: Color.fromARGB(255, 21, 87, 23),
          ),
          label: Text(
            'E-mail',
            style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
          ),
        ),
      ),
    );
  }

  Container inputPassword() {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: TextFormField(
        controller: _password,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Password';
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
            Icons.lock,
            color: Color.fromARGB(255, 21, 87, 23),
          ),
          label: Text(
            'Password',
            style: TextStyle(color: Color.fromARGB(255, 21, 87, 23)),
          ),
        ),
      ),
    );
  }
}
