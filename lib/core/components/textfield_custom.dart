import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatelessWidget {
  // // ignore: use_key_in_widget_constructors
  // TextFieldSignIn({
  //   Key? key,

  //   required this.text,
  //   required this.controller,
  //   this.iconSvg = '',
  // });

  // final IconData icon;
  // final String text;
  // final String iconSvg;
  // TextEditingController controller = TextEditingController();
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool isOutlineBorder;
  final IconData icon;

  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.isOutlineBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24.0,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: label,
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
