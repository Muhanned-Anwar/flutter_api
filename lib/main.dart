import 'package:flutter/material.dart';
import 'package:flutter_api/screens/auth/reset_password_screen.dart';
import 'package:flutter_api/prefs/student_preferences_controller.dart';
import 'package:flutter_api/screens/auth/forget_password_screen.dart';
import 'package:flutter_api/screens/auth/login_screen.dart';
import 'package:flutter_api/screens/auth/register_screen.dart';
import 'package:flutter_api/screens/categories_screen.dart';
import 'package:flutter_api/screens/images/images_screen.dart';
import 'package:flutter_api/screens/images/upload_image_screen.dart';
import 'package:flutter_api/screens/launch_screen.dart';
import 'package:flutter_api/screens/users_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StudentPreferenceController().initSharePreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/forget_password_screen': (context) => ForgetPasswordScreen(),
        // '/reset_password_screen':(context) => ResetPasswordScreen(),
        '/users_screen': (context) => UsersScreen(),
        '/categories_screen': (context) => CategoriesScreen(),
        '/images_screen': (context) => ImagesScreen(),
        '/upload_image_screen': (context) => UploadImageScreen(),
      },
    );
  }
}
