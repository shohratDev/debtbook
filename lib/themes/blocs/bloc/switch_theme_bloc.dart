import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'switch_theme_event.dart';
part 'switch_theme_state.dart';

class SwitchThemeBloc extends HydratedBloc<SwitchThemeEvent, SwitchThemeState> {
  SwitchThemeBloc() : super(const SwitchThemeInitial(switchValue: false)) {
    // switch on event
    on<SwitchOnEvent>((event, emit) {
      emit(const SwitchThemeState(switchValue: true));
    });

    // switch off event
    on<SwitchOffEvent>((event, emit) {
      emit(const SwitchThemeState(switchValue: false));
    });
  }

  @override
  SwitchThemeState? fromJson(Map<String, dynamic> json) {
    return SwitchThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchThemeState state) {
    return state.toMap();
  }
}
