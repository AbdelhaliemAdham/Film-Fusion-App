import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/data/auth_controller.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/routes.dart';
import 'package:movie/helper/snackbar.dart';

import '../../widgets/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String dataBasePassword = "Abdo_2025^%";
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.4,
            image: const AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                height: 250,
                child: Text(
                  'Login to Your Account',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(letterSpacing: 2),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value != null &&
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return null;
                      }
                      {
                        return "Invalid email ";
                      }
                    },
                    controller: _emailController,
                    style: const TextStyle(color: Colors.grey),
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.isNotEmpty &&
                          value.length >= 12 &&
                          value.length <= 6) {
                        return 'please enter password from from 6 to 12 numbers ';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.grey),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      errorBorder: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.95,
                height: 200,
                child: SignInButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await authController
                          .loginWithEmailAndPassword(
                              _emailController.text, _passwordController.text)
                          .then((message) {
                        if (message == 'user-not-found') {
                          HelperFun.showSnackBarWidegt(
                              "We Can't find this user, please Regiser before login",
                              'Authintication');
                        } else if (message == 'wrong-password') {
                          HelperFun.showSnackBarWidegt(
                              "Wrong password,please retype the password field with correct password",
                              'Authintication');
                        } else {
                          HelperFun.showSnackBarWidegt(
                              message.toString(), 'Authintication Message');
                        }
                      });
                      Navigator.pushNamed(context, StaticRoutes.mainScreen);
                    }
                  },
                  text: 'Sign in',
                  color: Colors.purple,
                  isLoading: isLoading,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, StaticRoutes.signUpScreen);
                },
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
