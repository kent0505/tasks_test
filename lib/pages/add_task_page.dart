import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../blocs/navbar/navbar_bloc.dart';
import '../models/cat.dart';
import '../models/task.dart';
import '../core/utils.dart';
import '../widgets/categories_widget.dart';
import '../widgets/page_title.dart';
import '../widgets/remind_button.dart';
import '../widgets/title_text.dart';
import '../widgets/txt_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  // List<Subtask> subtasks = [];
  Cat cat = Cat(id: 0, title: '');
  bool remind = false;
  bool active = false;

  void onChanged() {
    setState(() {
      active = [
            controller1,
            controller3,
            controller4,
          ].every((controller) => controller.text.isNotEmpty) &&
          cat.id != 0;
    });
  }

  // void onAddSubtask() {
  //   setState(() {
  //     subtasks.add(Subtask(
  //       id: subtasks.length,
  //       title: '',
  //       done: false,
  //     ));
  //   });
  // }

  // void onSubtaskDone(Subtask value) {
  //   setState(() {
  //     for (Subtask subtask in subtasks) {
  //       if (subtask.id == value.id) subtask.done = !subtask.done;
  //     }
  //   });
  // }

  // void onSubtaskDelete(Subtask value) {
  //   setState(() {
  //     subtasks.removeWhere((element) => element.id == value.id);
  //   });
  // }

  void onCat(Cat value) {
    cat.id == value.id ? cat = Cat(id: 0, title: '') : cat = value;
    onChanged();
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
              // subtasks: subtasks,
              cat: cat,
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
            ).copyWith(bottom: 75),
            children: [
              const SizedBox(height: 8),
              const TitleText('Add a title for your task'),
              const SizedBox(height: 8),
              TxtField(
                controller: controller1,
                hintText: 'Title',
                onChanged: onChanged,
              ),
              // const SizedBox(height: 16),
              // ...List.generate(
              //   subtasks.length,
              //   (index) {
              //     return SubtaskField(
              //       onDone: onSubtaskDone,
              //       onDelete: onSubtaskDelete,
              //       subtask: subtasks[index],
              //     );
              //   },
              // ),
              // SubtaskAddButton(onPressed: onAddSubtask),
              const SizedBox(height: 16),
              const TitleText('Select a category for your task (optional)'),
              const SizedBox(height: 8),
              CategoriesWidget(
                cat: cat,
                onPressed: onCat,
              ),
              const SizedBox(height: 16),
              const TitleText('Set a date for your task'),
              const SizedBox(height: 8),
              TxtField(
                controller: controller2,
                hintText: 'Starts',
                onChanged: onChanged,
                datePicker: true,
              ),
              const SizedBox(height: 16),
              const TitleText('Set a time for your task'),
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
              RemindButton(
                active: remind,
                onPressed: onRemind,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
