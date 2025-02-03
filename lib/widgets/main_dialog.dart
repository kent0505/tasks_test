import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import 'button.dart';

class MainDialog extends StatelessWidget {
  const MainDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonTitle1,
    required this.buttonTitle2,
    required this.onPressed1,
    required this.onPressed2,
  });

  final String title;
  final String content;
  final String buttonTitle1;
  final String buttonTitle2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 138,
        width: 270,
        decoration: BoxDecoration(
          color: AppColors.dialog1,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontFamily: 'w700',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontFamily: 'w500',
                  ),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: const Color(0xff545458).withValues(alpha: 0.65),
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    onPressed: () {
                      onPressed1();
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        buttonTitle1,
                        style: const TextStyle(
                          color: AppColors.dialog3,
                          fontSize: 17,
                          fontFamily: 'w500',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 44,
                  width: 0.5,
                  color: const Color(0xff545458).withValues(alpha: 0.65),
                ),
                Expanded(
                  child: Button(
                    onPressed: () {
                      onPressed2();
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        buttonTitle2,
                        style: const TextStyle(
                          color: AppColors.dialog2,
                          fontSize: 17,
                          fontFamily: 'w700',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
