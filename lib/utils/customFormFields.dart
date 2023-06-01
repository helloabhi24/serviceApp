import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:service/constant/constant.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    this.inputType = TextInputType.text,
    this.label,
    this.maxLength = 18,
    this.readOnly = false,
    this.isObscureText = false,
    this.isCollapsed = false,
    this.validator,
    this.prefixText,
    this.onTapAction,
    this.inputFormator,
    this.trailing,
    this.padding,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.shape,
    this.onChanged,
    this.hint,
    this.isPrefix,
    this.isMaxLength,
    this.textInputAction,
    this.maxLines,
    this.isSuffix,
    this.ontap,
    this.focusNode,
    this.focusNodes,
    this.contentPadding,
    this.icons,
  }) : super(key: key);

  final TextEditingController controller;
  final InputBorder? shape;
  final TextInputType? inputType;
  final String? label, prefixText;
  final bool readOnly, isObscureText, isCollapsed;
  final Widget? trailing;
  final int? maxLength;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormator;
  final AutovalidateMode? autovalidateMode;
  final VoidCallback? onTapAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? focusNodes;
  final TextInputAction? textInputAction;
  final String? hint;
  final bool? isPrefix, isMaxLength, maxLines, isSuffix;
  final Function? ontap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormator,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      onFieldSubmitted: focusNodes,
      focusNode: focusNode,
      maxLines: maxLines == true ? 7 : 1,
      controller: controller,
      maxLength: isMaxLength == true ? 10 : null,
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: isPrefix == true
            ? Icon(
                icons,
                color: KColors.persistentBlack,
                size: 16.sp,
              )
            : null,
        contentPadding: contentPadding,
        counterText: "",
        labelText: label,
        suffixIcon: isSuffix == true
            ? IconButton(
                onPressed: () {
                  ontap!();
                },
                icon: const Icon(
                  Icons.gps_fixed,
                  color: KColors.persistentBlack,
                ))
            : null,
        labelStyle: const TextStyle(
          color: KColors.persistentBlack,
        ),
        helperStyle: const TextStyle(
          color: KColors.persistentBlack,
        ),
        errorStyle: const TextStyle(color: Colors.red),
        hintText: hint,
        hintStyle:
            const TextStyle(color: KColors.persistentBlack, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: KColors.persistentBlack, width: .4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: KColors.persistentBlack, width: .4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: .4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black, width: .4),
        ),
      ),
    );
  }
}
