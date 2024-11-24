import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/helper/binding.dart';
import 'package:movie/helper/routes.dart';
import 'package:movie/helper/themes.dart';
import 'package:movie/screens/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://vwrueiuqiowptrhojabx.supabase.co';
const supabaseKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ3cnVlaXVxaW93cHRyaG9qYWJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIyOTE2NjksImV4cCI6MjA0Nzg2NzY2OX0.elrjMuHORQDLUIWa1K3ciH9D_ZKPCNguHE4N_P-jylw');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: 'public-anon-key',
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      title: 'FoxMovies',
      // initialRoute: StaticRoutes.authGate,
      routes: StaticRoutes.routes,
      theme: ThemeData(
        fontFamily: 'Roboto',
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(14, 15, 22, 1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(14, 15, 22, 1),
        ),
        textTheme: Themes.getTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromRGBO(14, 15, 22, 1),
      ),
      home: const AuthGate(),
    );
  }
}
