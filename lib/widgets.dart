import 'package:flutter/material.dart';
import 'package:flutter_flask/constants.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.email_outlined),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.onTapSuffix,
    this.visible = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final bool visible;
  final void Function() onTapSuffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: !visible,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide.none,
        ),
        suffixIcon: GestureDetector(
          onTap: onTapSuffix,
          child: visible
              ? const Icon(Icons.visibility_outlined)
              : const Icon(Icons.visibility_off_outlined),
        ),
        prefixIcon: const Icon(Icons.lock_outline),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(cornerRadius),
      color: deepColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 64,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
    required this.suggestion,
    required this.action,
    this.onAction,
  }) : super(key: key);

  final String suggestion;
  final String action;
  final void Function()? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 6),
        Text(suggestion, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onAction,
          child: Text(action, style: Theme.of(context).textTheme.subtitle2),
        ),
      ],
    );
  }
}
