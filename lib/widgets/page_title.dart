import 'package:flutter/material.dart';

import '../core/config/app_colors.dart';
import 'button.dart';
import 'svg_widget.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.back = true,
    this.active = true,
    this.buttonTitle = '',
    this.onPressed,
  });

  final String title;
  final bool back;
  final bool active;
  final String buttonTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Row(
        children: [
          const SizedBox(width: 16),
          if (back)
            Button(
              onPressed: Navigator.of(context).pop,
              child: const SvgWidget('assets/back.svg'),
            ),
          if (back) const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              textAlign: back ? TextAlign.center : null,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
          ),
          if (onPressed != null)
            SizedBox(
              width: 60,
              child: Button(
                onPressed: active ? onPressed : null,
                child: Text(
                  buttonTitle,
                  style: TextStyle(
                    color: active ? AppColors.accent : AppColors.text1,
                    fontSize: 18,
                    fontFamily: 'w700',
                  ),
                ),
              ),
            ),
          SizedBox(width: back && onPressed == null ? 76 : 16),
        ],
      ),
    );
  }
}
