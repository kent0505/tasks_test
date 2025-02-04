import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/navbar/navbar_bloc.dart';
import '../widgets/bottom_nav.dart';
import 'settings_page.dart';
import 'add_task_page.dart';
import 'tasks_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlocBuilder<NavbarBloc, NavbarState>(
            builder: (context, state) {
              if (state is NavbarAdd) return const AddTaskPage();

              if (state is NavbarSettings) return const SettingsPage();

              return const TasksPage();
            },
          ),
          const BottomNav(),
        ],
      ),
    );
  }
}
