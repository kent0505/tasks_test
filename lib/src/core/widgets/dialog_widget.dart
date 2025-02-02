import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import 'button.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    this.onlyClose = false,
    required this.onYes,
  });

  final String title;
  final bool onlyClose;
  final void Function() onYes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.main,
      child: SizedBox(
        height: 150,
        width: 200,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            if (onlyClose)
              _Button(
                title: 'Close',
                onPressed: () {
                  Navigator.pop(context);
                  onYes;
                },
              )
            else
              Row(
                children: [
                  const SizedBox(width: 20),
                  _Button(
                    title: 'No',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  _Button(
                    title: 'Yes',
                    onPressed: () {
                      Navigator.pop(context);
                      onYes();
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      padding: 0,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
