import 'package:chat_app_1/firebase_options.dart';
import 'package:chat_app_1/pages/blocs/bloc/auth_bloc.dart';
import 'package:chat_app_1/pages/chat_page.dart';
import 'package:chat_app_1/pages/cubits/chat/cubit/chat_cubit.dart';
import 'package:chat_app_1/pages/cubits/cubit/auth_cubit.dart';
import 'package:chat_app_1/pages/register_page.dart';
import 'package:chat_app_1/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(ScholarChat());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
      ),
    );
  }
}
