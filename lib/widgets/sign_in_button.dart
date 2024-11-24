// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SignInButton extends StatefulWidget {
  VoidCallback onPressed;
  Color color;
  String text;
  bool isLoading;
  SignInButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 50,
          width: MediaQuery.sizeOf(context).width - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.grey.shade300),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
