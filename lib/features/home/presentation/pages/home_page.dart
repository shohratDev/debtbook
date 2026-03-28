import 'package:debtbook/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:debtbook/features/auth/presentation/components/my_button.dart';
import 'package:debtbook/features/auth/presentation/pages/login_screen.dart';
import 'package:debtbook/themes/blocs/bloc/switch_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          final snackBar = SnackBar(content: Text(state.error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        print("state is _______ $state");
        //
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          // Аторизированный user

          final user = state.user;

          //
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Hello     ${user.email}")),

                SizedBox(height: 20),

                // change theme box
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Change the theme"),
                        BlocBuilder<SwitchThemeBloc, SwitchThemeState>(
                          builder: (context, state) {
                            return Switch(
                              value: state.switchValue,
                              onChanged: (newValue) {
                                newValue
                                    ? context.read<SwitchThemeBloc>().add(
                                      SwitchOnEvent(),
                                    )
                                    : context.read<SwitchThemeBloc>().add(
                                      SwitchOffEvent(),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                MyButton(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogOutRequested());
                  },
                  text: "Logout",
                ),
              ],
            ),
          );
        }

        return const AuthPage();
      },
    );
  }
}
