import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_colors.dart';
import '../config/themes.dart';
import '../utils.dart';
import 'button.dart';
import 'svg_widget.dart';

class TxtField extends StatefulWidget {
  const TxtField({
    super.key,
    required this.controller,
    required this.hintText,
    this.number = false,
    this.datePicker = false,
    this.timePicker = false,
    this.prefix = false,
    this.length = 20,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool number;
  final bool datePicker;
  final bool timePicker;
  final bool prefix;
  final int length;
  final void Function() onChanged;

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  DateTime time = DateTime.now();

  void onSave() {
    setState(() {
      widget.controller.text = timeToString(time);
    });
    widget.onChanged();
  }

  void onDateTimeChanged(DateTime value) {
    time = value;
  }

  Widget? _buildPrefixIcon() {
    return widget.prefix
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgWidget('assets/search.svg')],
          )
        : null;
  }

  Widget? _buildSuffixIcon() {
    return widget.datePicker || widget.timePicker
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgWidget(
                widget.datePicker ? 'assets/calendar.svg' : 'assets/clock.svg',
              ),
            ],
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.tertiary1,
        borderRadius: BorderRadius.circular(52),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.number ? TextInputType.number : null,
        readOnly: widget.datePicker || widget.timePicker,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.length),
          if (widget.number) FilteringTextInputFormatter.digitsOnly,
        ],
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'w700',
        ),
        decoration: InputDecoration(
          prefixIcon: _buildPrefixIcon(),
          suffixIcon: _buildSuffixIcon(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.text1,
            fontSize: 14,
            fontFamily: 'w500',
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          widget.onChanged();
        },
        onTap: () async {
          if (widget.datePicker) {
            // await showCupertinoModalPopup(
            //   context: context,
            //   builder: (context) {
            //     return _Picker(
            //       child: CupertinoDatePicker(
            //         onDateTimeChanged: onDateTimeChanged,
            //         initialDateTime: stringToDate(widget.controller.text),
            //         mode: CupertinoDatePickerMode.date,
            //         minimumYear: 1950,
            //         maximumYear: DateTime.now().year + 1,
            //       ),
            //     );
            //   },
            // );
          }

          if (widget.timePicker) {
            await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return _Picker(
                  onSave: onSave,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: onDateTimeChanged,
                    initialDateTime: time,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({
    required this.child,
    required this.onSave,
  });

  final Widget child;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 252,
      decoration: const BoxDecoration(
        color: AppColors.tertiary1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Button(
                    onPressed: Navigator.of(context).pop,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 17,
                        fontFamily: 'w500',
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Select Time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontFamily: 'w500',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: Button(
                    onPressed: () {
                      Navigator.pop(context);
                      onSave();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 17,
                        fontFamily: 'w500',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoTheme(
              data: cupertinoTheme,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
