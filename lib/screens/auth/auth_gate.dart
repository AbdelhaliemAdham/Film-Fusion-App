import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie/screens/auth/login_screen.dart';
import 'package:movie/screens/main_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool connected = false;
  // internetConnectionChecker() async {
  //   InternetConnectionChecker().onStatusChange.listen((status) {
  //     switch (status) {
  //       case InternetConnectionStatus.connected:
  //         setState(() {
  //           connected = true;
  //         });
  //         break;
  //       case InternetConnectionStatus.disconnected:
  //         setState(() {
  //           connected = false;
  //         });
  //         break;
  //     }
  //   });
  // }

  // @override
  // initState() {
  //   super.initState();
  //   internetConnectionChecker();
  // }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
        initialData: auth.currentUser,
        stream: auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return const LoginScreen();
          }

          return const MainScreen();
        });
  }
}
