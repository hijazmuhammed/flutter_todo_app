import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';

/// Profile section with avatar and greeting text
/// Can trigger drawer or navigate to profile
class ProfileSection extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;
  final String greeting;
  final String userName;
  
  const ProfileSection({
    super.key,
    this.onTap,
    this.imagePath = 'lib/core/assets/profile_image.png',
    this.greeting = AppStrings.hello,
    this.userName = AppStrings.liviaVaccaro,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: AppTextStyles.bodyLarge,
              ),
              Text(
                userName,
                style: AppTextStyles.h2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

