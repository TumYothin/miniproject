import 'package:flutter/material.dart';
import '../sevices/auth_seveice.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(children: [
            Image.asset(
              'assets/logo.png',
              width: 70,
            ),
            inputname(),
            inputEmail(),
            inputPassword(),
            formButton(),
          ]),
        ),
      ),
    );
  }

  Container formButton() {
    double width = 320;
    double height = 55;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          signupButton(width, height),
        ],
      ),
    );
  }

  SizedBox signupButton(double width, double height) {
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
              registerUser(_username.text, _email.text, _password.text)
                  .then((value) => {
                        if (value != null)
                          {print('add complete'), Navigator.pop(context)}
                        else
                          {print('error')}
                      });
            }
          },
          child: const Text('Signup')),
    );
  }

  Container inputEmail() {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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

  Container inputname() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
      child: TextFormField(
        controller: _username,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Your name';
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
            Icons.account_box,
            color: Color.fromARGB(255, 21, 87, 23),
          ),
          label: Text(
            'Name',
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
