import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/bloc/task_bloc.dart';
import 'src/core/config/themes.dart';
import 'src/blocs/navbar/navbar_bloc.dart';
import 'src/features/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavbarBloc()),
        BlocProvider(create: (context) => TaskBloc()..add(GetTask())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashPage(),
      ),
    );
  }
}
