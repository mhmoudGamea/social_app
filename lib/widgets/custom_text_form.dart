import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/user_data_provider.dart';

class CustomTextForm extends StatefulWidget {
  final String hint;
  final TextInputType type;
  bool isObscure;
  final void Function(String value) onChange;
  final String? Function(String? value) validate;
  final Color borderColor;
  TextEditingController? text;

  CustomTextForm({
    Key? key,
    required this.hint,
    this.type = TextInputType.text,
    this.isObscure = false,
    required this.onChange,
    required this.validate,
    this.borderColor = darkPurple,
    this.text,
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  void suffixTap() {
    setState(() {
      widget.isObscure = !widget.isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserDataProvider>(context);
    return Container(
      height: 53,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.borderColor, width: 1.2),
      ),
      child: TextFormField(
        controller: widget.text,
        cursorColor: Colors.black,
        style: TextStyle(color: data.getDarkMode ? Colors.grey.withOpacity(0.5) : Colors.black),
        keyboardType: widget.type,
        obscureText: widget.isObscure,
        onChanged: widget.onChange,
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          suffixIcon: widget.type == TextInputType.visiblePassword
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: InkWell(
                      onTap: suffixTap,
                      child: SvgPicture.asset(
                        widget.isObscure
                            ? 'assets/images/eye.svg'
                            : 'assets/images/eye_slash.svg',
                        color: data.getDarkMode ? Colors.white : Colors.black,
                        width: 25,
                      )),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
