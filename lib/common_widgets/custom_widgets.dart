import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class customTextField extends StatefulWidget {
  final String? title;
  final String? hint;
  final FormFieldValidator validator;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;

  customTextField({
    Key? key,
    this.title,
    this.hint,
    required this.validator,
    this.obscureText = false,
    required this.controller,
    required this.textInputType,
  }) : super(key: key);

  @override
  _customTextFieldState createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? '',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 400,
            child: TextFormField(
              obscureText: _isObscure,
              validator: widget.validator,
              keyboardType: widget.textInputType,
              controller: widget.controller, 
              decoration: InputDecoration(
                hintText: widget.hint,
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )
                    : null,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
