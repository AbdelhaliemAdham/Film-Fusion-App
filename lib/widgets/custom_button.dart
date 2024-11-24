// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color color;
  final String? image;
  final Color? imageColor;
  bool isLoading;
  final VoidCallback onPressed;
  CustomButton({
    Key? key,
    required this.text,
    required this.color,
    this.image,
    this.imageColor,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.grey.shade300),
                    ),
              const SizedBox(width: 8),
              widget.image != null
                  ? Image.asset(
                      widget.image!,
                      color: widget.imageColor,
                      width: 20,
                      height: 20,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
