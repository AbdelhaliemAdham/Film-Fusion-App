import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie/data/auth_controller.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/helper/snackbar.dart';
import 'package:movie/screens/profile_screen.dart';
import 'package:movie/widgets/sign_in_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool imageGetPicked = false;
  File? image;
  String? imageSupbaseUrl;
  final supabase = Supabase.instance.client;

  String path = "uploads/${DateTime.now().microsecondsSinceEpoch.toString()}";
  createBucket() async {
    if (imageGetPicked && image != null) {
      await supabase.storage
          .from('profileImage')
          .upload(
            path,
            image!,
          )
          .then((value) {
        imageSupbaseUrl = value; // this is the url of the uploaded image
      });
    }
    return;
  }

  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageGetPicked = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
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
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(Assets.backgroundImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    height: 70,
                    child: Text(
                      'Create New Account',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(letterSpacing: 2),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 140,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: imageGetPicked
                              ? FileImage(image!) as ImageProvider
                              : const AssetImage(
                                  Assets.person,
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 40,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                backgroundColor: const Color(0xFFF5F6F9),
                              ),
                              onPressed: () async {
                                await pickImageFromGallery();
                              },
                              child: SvgPicture.string(cameraIcon),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Full Name';
                          }
                          return null;
                        },
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Full Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.grey),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.grey),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Phone';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Phone',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: SignInButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            imageGetPicked == true) {
                          setState(() {
                            isLoading = true;
                          });
                          // await createBucket();
                          // ignore: use_build_context_synchronously
                          final message = await authController.createUser(
                            _emailController.text,
                            _passwordController.text,
                            _fullNameController.text,
                            context,
                            image,
                            _phoneController.text,
                          );
                          HelperFun.showSnackBarWidegt(
                              'Authintication', message);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      color: Colors.purple,
                      text: 'Sign up',
                      isLoading: isLoading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "You have an account? ",
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
