import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? isPassword;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.isPassword,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  widget.controller.clear();
                },
                icon: Icon(Icons.clear_rounded),
              ),
              if (widget.isPassword == true)
                IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
            ],
          ),
        ),
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.grey.shade300,
        contentPadding: EdgeInsets.only(left: 15),
      ),
    );
  }
}
