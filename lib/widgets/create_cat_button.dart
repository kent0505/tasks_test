import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/config/app_colors.dart';
import '../core/models/cat.dart';
import 'button.dart';
import 'svg_widget.dart';

class CreateCatButton extends StatelessWidget {
  const CreateCatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return const _CreateDialog();
          },
        );
      },
      minSize: 36,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.tertiary2,
          borderRadius: BorderRadius.circular(36),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget(
              'assets/add.svg',
              color: AppColors.white,
            ),
            SizedBox(width: 4),
            Text(
              'Create New',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateDialog extends StatefulWidget {
  const _CreateDialog();

  @override
  State<_CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<_CreateDialog> {
  final controller = TextEditingController();
  int id = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        width: 356,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.tertiary1,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 44),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Create Category',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontFamily: 'w700',
                      ),
                    ),
                  ),
                ),
                Button(
                  onPressed: Navigator.of(context).pop,
                  child: const SvgWidget('assets/close.svg'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Add a title for your category',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.tertiary2,
                borderRadius: BorderRadius.circular(52),
              ),
              child: TextField(
                controller: controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontFamily: 'w700',
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  hintText: 'Title',
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
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select icon for category ',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontFamily: 'w700',
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                15,
                (index) {
                  return _Cat(
                    id: index + 1,
                    current: id,
                    onPressed: (value) {
                      setState(() {
                        id == value ? id = 0 : id = value;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _Button(
                  title: 'Cancel',
                  titleColor: AppColors.white,
                  color: AppColors.tertiary1,
                  onPressed: Navigator.of(context).pop,
                ),
                const SizedBox(width: 8),
                _Button(
                  title: 'Create',
                  titleColor: AppColors.main,
                  color: AppColors.accent,
                  active: controller.text.isNotEmpty && id != 0,
                  onPressed: () {
                    context.read<TaskBloc>().add(
                          CreateCat(
                            cat: Cat(
                              id: id,
                              title: controller.text,
                            ),
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Cat extends StatelessWidget {
  const _Cat({
    required this.id,
    required this.current,
    required this.onPressed,
  });

  final int id;
  final int current;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        onPressed(id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.tertiary2,
          border: Border.all(
            width: 1.5,
            color: id == current ? AppColors.accent : Colors.transparent,
          ),
        ),
        child: Center(
          child: SvgWidget('assets/cat/cat$id.svg'),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.titleColor,
    required this.color,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final Color titleColor;
  final Color color;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Button(
        onPressed: active ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 52,
          decoration: BoxDecoration(
            color: active ? color : AppColors.text1,
            borderRadius: BorderRadius.circular(52),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
