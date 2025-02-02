import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/app_colors.dart';
import '../../core/utils.dart';
import '../../blocs/navbar/navbar_bloc.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/svg_widget.dart';
import '../settings/settings_page.dart';
import '../task/add_task_page.dart';
import 'tasks_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BlocConsumer<NavbarBloc, NavbarState>(
            listener: (context, state) {
              logger(state.runtimeType);
            },
            builder: (context, state) {
              if (state is NavbarAdd) return const AddTaskPage();

              if (state is NavbarSettings) return const SettingsPage();

              return const TasksPage();
            },
          ),
          const _NavBar(),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 75,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: AppColors.tertiary2,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            Container(
              height: 73,
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: AppColors.main,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: BlocBuilder<NavbarBloc, NavbarState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavBarButton(
                        id: 1,
                        title: 'Tasks',
                        active: state is NavbarInitial,
                      ),
                      _NavBarButton(
                        id: 2,
                        title: 'Add Task',
                        active: state is NavbarAdd,
                      ),
                      _NavBarButton(
                        id: 3,
                        title: 'Settings',
                        active: state is NavbarSettings,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.id,
    required this.title,
    required this.active,
  });

  final int id;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: active
          ? null
          : () {
              context.read<NavbarBloc>().add(ChangePage(index: id));
            },
      padding: 0,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment:
              active ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: [
            SvgWidget(
              'assets/tab/tab$id.svg',
              color: active ? AppColors.accent : AppColors.tertiary2,
            ),
            if (active) ...[
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontFamily: 'w700',
                ),
              ),
              const SizedBox(height: 5),
              const SvgWidget('assets/active.svg'),
            ],
          ],
        ),
      ),
    );
  }
}
