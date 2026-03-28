part of 'switch_theme_bloc.dart';

class SwitchThemeState extends Equatable {
  final bool switchValue;
  const SwitchThemeState({required this.switchValue});

  @override
  List<Object> get props => [switchValue];

  factory SwitchThemeState.fromMap(Map<String, dynamic> map) {
    return SwitchThemeState(switchValue: map['switchValue'] ?? false);
  }

  Map<String, dynamic>? toMap() {
    return {'switchValue': switchValue};
  }
}

final class SwitchThemeInitial extends SwitchThemeState {
  const SwitchThemeInitial({required bool switchValue})
    : super(switchValue: switchValue);
}
