import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:movie/screens/auth/login_screen.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Future<String> uploadImageToStorage(File? file) async {
  //   UploadTask uploadTask = _firebaseStorage
  //       .ref()
  //       .child('profileImages')
  //       .child(_auth.currentUser!.uid)
  //       .putFile(file!);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   return taskSnapshot.ref.getDownloadURL();
  // }

  Future<String> createUser(
    String email,
    String password,
    String? fullName,
    BuildContext context,
    File? file,
    String? phoneNumber,
  ) async {
    String? message;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'fullName': fullName,
        'password': password,
        'buyerId': userCredential.user!.uid,
        'phoneNumber': phoneNumber,
      });
      message = 'user registered succesfully';
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      message = e.toString();
    }
    return message;
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    String? message;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      message = 'logged in successfuly';
    } on FirebaseAuthException catch (e) {
      message = e.toString();
    }
    return message;
  }
}
