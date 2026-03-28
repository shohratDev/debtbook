import 'package:debtbook/features/auth/domain/models/app_user.dart';
import 'package:debtbook/features/auth/domain/repos/auth_repos.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepository;
  AppUser? currentUser;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogInRequested>(_onLogInRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogOutRequested>(_onLogOutRequested);
  }

  // check if user is authenticated
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    // loading
    emit(AuthLoading());

    // get current user
    final AppUser? user = await authRepository.getCurrentUser();

    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  //
  Future<void> _onLogInRequested(
    AuthLogInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.loginWithEmailPassword(
        event.email,
        event.password,
      );
      emit(AuthAuthenticated(user: user!));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  //
  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.registerWithEmailPassword(
        event.email,
        event.password,
      );

      emit(AuthAuthenticated(user: user!));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  //
  Future<void> _onLogOutRequested(
    AuthLogOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
