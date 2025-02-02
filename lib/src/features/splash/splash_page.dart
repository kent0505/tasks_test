import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/task_bloc.dart';
import '../../core/widgets/loading_widget.dart';
import '../home/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskLoaded) {
            Future.delayed(
              const Duration(milliseconds: 300),
              () {
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                    (route) => false,
                  );
                }
              },
            );
          }
        },
        builder: (context, state) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: state is TaskLoaded ? 0 : 1,
            child: const Center(
              child: LoadingWidget(),
            ),
          );
        },
      ),
    );
  }
}
