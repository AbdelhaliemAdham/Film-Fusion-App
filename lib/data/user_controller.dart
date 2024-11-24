import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie/Models/user.dart';

class UserController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<UserModel> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      Map<String, dynamic>? data = snapshot.data();
      return UserModel.fromJson(data!);
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}
