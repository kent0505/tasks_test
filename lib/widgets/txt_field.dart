import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/config/app_colors.dart';
import '../core/config/themes.dart';
import '../core/utils.dart';
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
    this.search = false,
    this.length = 20,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final bool number;
  final bool datePicker;
  final bool timePicker;
  final bool search;
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
          prefixIcon: widget.search
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgWidget('assets/search.svg')],
                )
              : null,
          suffixIcon: widget.datePicker || widget.timePicker
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgWidget(
                      widget.datePicker
                          ? 'assets/calendar.svg'
                          : 'assets/clock.svg',
                    ),
                  ],
                )
              : null,
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
          if (widget.search) {
            context.read<TaskBloc>().add(SearchTasks());
          }

          if (widget.timePicker) {
            await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return _Picker(
                  onSave: onSave,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (value) {
                      time = value;
                    },
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
      color: AppColors.tertiary1,
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
                        fontFamily: 'w700',
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
