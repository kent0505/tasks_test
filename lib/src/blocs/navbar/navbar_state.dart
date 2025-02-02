part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {}

final class NavbarInitial extends NavbarState {}

final class NavbarAdd extends NavbarState {}

final class NavbarSettings extends NavbarState {}
