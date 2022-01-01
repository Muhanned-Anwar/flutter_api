import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/api/controllers/student_api_controller.dart';
import 'package:flutter_api/screens/auth/Widgets/text_field_login_screen.dart';
import 'package:flutter_api/utils/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            'Welcome back...',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Enter email & password',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          // TextFieldLoginScreen(
          //   hintText: 'Email',
          //   prefixIcon: Icon(Icons.email),
          //   keyboardType: TextInputType.emailAddress,
          //   textEditingController: _emailTextController,
          // ),
          SizedBox(height: 10),
          TextField(
            controller: _passwordTextController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          // TextFieldLoginScreen(
          //   hintText: 'Password',
          //   prefixIcon: Icon(Icons.lock),
          //   keyboardType: TextInputType.text,
          //   obscureText: true,
          //   textEditingController: _passwordTextController,
          // ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await performLogin(),
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 0,maxHeight: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account '),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: Text('Create Now!'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    // backgroundColor: Colors.red,
                    minimumSize: Size(0, 20),
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 0,maxHeight: 20),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forget_password_screen');
              },
              child: Text('Forget Password?'),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  // backgroundColor: Colors.yellowAccent,
                  minimumSize: Size(0, 20)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data',error: true,time: 1);
    return false;
  }

  Future<void> login() async {
    bool status = await StudentApiController().login(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      print('SUCCESS');
      showSnackBar(
          context: context,
          message: 'Login successfully..',
          error: false,
          time: 1);
      Navigator.pushReplacementNamed(context, '/users_screen');
    } else {
      print('Failed');
      showSnackBar(
          context: context,
          message: 'Login failed!, try again',
          error: true,
          time: 2);
    }
  }
}
