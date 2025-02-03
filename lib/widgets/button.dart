import 'package:flutter/cupertino.dart';

import '../core/app_colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    this.padding = 0,
    this.minSize = kMinInteractiveDimensionCupertino,
    required this.child,
  });

  final void Function()? onPressed;
  final double padding;
  final double minSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'w600',
            color: AppColors.black,
          ),
          // dateTimePickerTextStyle: TextStyle(
          //   color: Colors.white,
          //   fontSize: 24,
          //   fontFamily: 'w400',
          // ),
        ),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(padding),
        minSize: minSize,
        child: child,
      ),
    );
  }
}
