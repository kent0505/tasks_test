import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import '../widgets/page_title.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageTitle(title: 'Privacy Policy'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              children: const [
                Text(
                  'Lorem ipsum',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontFamily: 'w700',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Dolor sit amet, consectetur adipiscing elit. Suspendisse tempus auctor nisi, eu mollis dui porttitor id. Suspendisse eget dapibus ligula. Integer vel eros urna. Curabitur magna dolor, viverra in bibendum sed, maximus ut neque. Quisque dapibus sagittis erat, venenatis finibus orci laoreet vitae. Curabitur et fermentum neque. Pellentesque non ligula id nunc sagittis egestas quis et purus. Dolor sit amet, consectetur adipiscing elit. Suspendisse tempus auctor nisi, eu mollis dui porttitor id. Suspendisse eget dapibus ligula. Integer vel eros urna. Curabitur magna dolor, viverra in bibendum sed, maximus ut neque. Quisque dapibus sagittis erat, venenatis finibus orci laoreet vitae. Curabitur et fermentum neque. Pellentesque non ligula id nunc sagittis egestas quis et purus.',
                  style: TextStyle(
                    color: AppColors.text2,
                    fontSize: 14,
                    fontFamily: 'w500',
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
