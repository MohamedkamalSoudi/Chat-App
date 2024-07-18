import 'package:chat_app_1/firebase_options.dart';
import 'package:chat_app_1/pages/chat_page.dart';
import 'package:chat_app_1/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
     );
    runApp(ScholarChat());
 }


class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      routes: {
        LoginPage.id: (context) =>  LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id : (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
    );
  }
}  