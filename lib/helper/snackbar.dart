import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFun {
  static showSnackBarWidegt(
    String message,
    String title,
  ) {
    return Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        snackPosition: SnackPosition.BOTTOM,
        shouldIconPulse: true,
        showProgressIndicator: false,
        messageText: Text(
          message,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        icon: const Icon(Icons.message, color: Colors.white, size: 35),
        backgroundColor: Colors.purple.withOpacity(0.7),
        duration: const Duration(seconds: 4),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
