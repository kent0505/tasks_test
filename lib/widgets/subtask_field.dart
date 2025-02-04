import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_colors.dart';
import '../models/subtask.dart';
import 'button.dart';
import 'check_widget.dart';
import 'svg_widget.dart';

class SubtaskField extends StatelessWidget {
  const SubtaskField({
    super.key,
    required this.subtask,
    required this.onDone,
    required this.onDelete,
  });

  final Subtask subtask;
  final void Function(Subtask) onDone;
  final void Function(Subtask) onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          CheckWidget(
            active: subtask.done,
            onPressed: () {
              onDone(subtask);
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: subtask.title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(),
                hintText: 'Type your sub-task',
                hintStyle: TextStyle(
                  color: AppColors.text1,
                  fontSize: 14,
                  fontFamily: 'w500',
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                subtask.title = value;
              },
            ),
          ),
          Button(
            onPressed: () {
              onDelete(subtask);
            },
            child: const SvgWidget('assets/delete.svg'),
          ),
        ],
      ),
    );
  }
}
