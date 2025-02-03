import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task/task_bloc.dart';
import '../core/db/hive.dart';
import '../core/models/cat.dart';
import '../core/models/task.dart';
import '../widgets/cat_card.dart';
import '../widgets/create_cat_button.dart';
import '../widgets/page_title.dart';
import '../widgets/remind_button.dart';
import '../widgets/title_text.dart';
import '../widgets/txt_field.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  late Cat cat;
  bool remind = false;
  bool active = true;

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

  void onCat(Cat value) {
    cat.id == value.id ? cat = Cat(id: 0, title: '') : cat = value;
    onChanged();
  }

  void onRemind() {
    setState(() {
      remind = !remind;
    });
  }

  void onEdit() {
    context.read<TaskBloc>().add(
          EditTask(
            task: Task(
              id: widget.task.id,
              title: controller1.text,
              cat: cat,
              date: controller2.text,
              startTime: controller3.text,
              endTime: controller4.text,
              remind: remind,
              done: widget.task.done,
            ),
          ),
        );
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.task.title;
    controller2.text = widget.task.date;
    controller3.text = widget.task.startTime;
    controller4.text = widget.task.endTime;
    cat = widget.task.cat;
    remind = widget.task.remind;
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
    return Scaffold(
      body: Column(
        children: [
          PageTitle(
            title: 'Edit Task',
            active: active,
            buttonTitle: 'Save',
            onPressed: onEdit,
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
                const TitleText('Select a cat for your task (optional)'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    cats.length,
                    (index) {
                      return CatCard(
                        cat: cats[index],
                        current: cat,
                        onPressed: onCat,
                      );
                    },
                  )..add(const CreateCatButton()),
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
      ),
    );
  }
}
