import 'package:chat_app_1/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

const primaryColor = Color(0xff2B475E);

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              onChanged: (data) {
                email = data;
              },
              hinText: 'Email',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onChanged: (data) {
                password = data;
              },
              hinText: 'Password',
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () async {
                  try {
                    await registerUser();
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showSnacBar(context, 'weak password');
                    } else if (e.code == 'email-already-in-use') {
                      showSnacBar(context, 'email already exists');
                    }
                  } catch (e) {
                    showSnacBar(context, 'there was an error');
                  }
                  showSnacBar(context, 'Success');
                },
                text: 'Register'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'dont\'t have a account? ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    ' Login',
                    style: TextStyle(
                      color: Color(0xffC7EDE6),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  void showSnacBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
