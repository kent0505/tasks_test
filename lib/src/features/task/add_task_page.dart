import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/task_bloc.dart';
import '../../blocs/navbar/navbar_bloc.dart';
import '../../core/config/app_colors.dart';
import '../../core/db/hive.dart';
import '../../core/models/category.dart';
import '../../core/models/subtask.dart';
import '../../core/models/task.dart';
import '../../core/utils.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/check_widget.dart';
import '../../core/widgets/page_title.dart';
import '../../core/widgets/svg_widget.dart';
import '../../core/widgets/txt_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final controller1 = TextEditingController(); // title
  final controller2 = TextEditingController(); // date
  final controller3 = TextEditingController(); // time start
  final controller4 = TextEditingController(); // time end
  List<Subtask> subtasks = [];

  Category? category;

  bool remind = false;
  bool active = false;

  void onChanged() {
    setState(() {
      active = [
        controller1,
        // controller2,
        controller3,
        controller4,
      ].every((controller) => controller.text.isNotEmpty);
    });
  }

  void onAddSubtask() {
    setState(() {
      subtasks.add(Subtask(
        id: subtasks.length,
        title: '',
        done: false,
      ));
    });
  }

  void onSubtaskDone(Subtask value) {
    setState(() {
      for (Subtask subtask in subtasks) {
        if (subtask.id == value.id) subtask.done = !subtask.done;
      }
    });
  }

  void onSubtaskDelete(Subtask value) {
    setState(() {
      subtasks.removeWhere((element) => element.id == value.id);
    });
  }

  void onCategory(Category value) {
    setState(() {
      category?.id == value.id ? category = null : category = value;
    });
  }

  void onRemind() {
    setState(() {
      remind = !remind;
    });
  }

  void onSave() {
    context.read<TaskBloc>().add(
          AddTask(
            task: Task(
              id: getTimestamp(),
              title: controller1.text,
              subtasks: subtasks,
              categoryId: category?.iconId ?? 0,
              date: controller2.text,
              startTime: controller3.text,
              endTime: controller4.text,
              remind: remind,
              done: false,
            ),
          ),
        );
    context.read<NavbarBloc>().add(ChangePage(index: 1));
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle(
          title: 'Create New Task',
          back: false,
          active: active,
          buttonTitle: 'Save',
          onPressed: onSave,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ).copyWith(bottom: 75),
            children: [
              const _TitleText('Add a title for your task'),
              const SizedBox(height: 8),
              TxtField(
                controller: controller1,
                hintText: 'Title',
                onChanged: onChanged,
              ),
              const SizedBox(height: 16),
              ...List.generate(
                subtasks.length,
                (index) {
                  return _SubtaskField(
                    onDone: onSubtaskDone,
                    onDelete: onSubtaskDelete,
                    subtask: subtasks[index],
                  );
                },
              ),
              _AddSubTask(onPressed: onAddSubtask),
              const SizedBox(height: 16),
              const _TitleText('Select a category for your task (optional)'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  categories.length,
                  (index) {
                    return _CategoryButton(
                      category: categories[index],
                      current: category,
                      onPressed: onCategory,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const _TitleText('Set a date for your task'),
              const SizedBox(height: 8),
              TxtField(
                controller: controller2,
                hintText: 'Starts',
                onChanged: onChanged,
                datePicker: true,
              ),
              const SizedBox(height: 16),
              const _TitleText('Set a time for your task'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TxtField(
                      controller: controller3,
                      hintText: 'Starts',
                      onChanged: onChanged,
                      timePicker: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TxtField(
                      controller: controller4,
                      hintText: 'Ends',
                      onChanged: onChanged,
                      timePicker: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _Remind(
                active: remind,
                onPressed: onRemind,
              ),
              const SizedBox(height: 83),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontFamily: 'w700',
      ),
    );
  }
}

class _AddSubTask extends StatelessWidget {
  const _AddSubTask({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: const SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgWidget('assets/add.svg'),
            SizedBox(width: 10),
            Text(
              'Add sub-tasks',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 18,
                fontFamily: 'w700',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubtaskField extends StatelessWidget {
  const _SubtaskField({
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
            child: TextField(
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

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.category,
    required this.current,
    required this.onPressed,
  });

  final Category category;
  final Category? current;
  final void Function(Category) onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        onPressed(category);
      },
      minSize: 36,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.tertiary2,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            width: 1.5,
            color: category.id == current?.id
                ? AppColors.accent
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgWidget('assets/cat/cat${category.iconId}.svg'),
            const SizedBox(width: 4),
            Text(
              category.title,
              style: const TextStyle(
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

class _Remind extends StatelessWidget {
  const _Remind({
    required this.active,
    required this.onPressed,
  });

  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            CheckWidget(
              active: active,
              onPressed: null,
            ),
            const SizedBox(width: 8),
            const Text(
              'Remind me',
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
