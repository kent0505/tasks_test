part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class ChangePage extends NavbarEvent {
  ChangePage({required this.index});

  final int index;
}
