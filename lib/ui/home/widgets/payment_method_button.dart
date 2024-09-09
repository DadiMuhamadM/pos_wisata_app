import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_wisata_app/core/components/spaces.dart';
import 'package:pos_wisata_app/core/constants/colors.dart';

class PaymentMethodButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  const PaymentMethodButton(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.isActive,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          border: Border.all(color: AppColors.stroke),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24.0,
              colorFilter: isActive
                  ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                  : null,
            ),
            const SpaceHeight(8.0),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.white : AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
