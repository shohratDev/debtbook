part of 'switch_theme_bloc.dart';

sealed class SwitchThemeEvent extends Equatable {
  const SwitchThemeEvent();

  @override
  List<Object> get props => [];
}

// on
class SwitchOnEvent extends SwitchThemeEvent {}

// of
class SwitchOffEvent extends SwitchThemeEvent {}
