import 'package:debtbook/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:debtbook/features/auth/presentation/components/apple_sign_in_button%20copy.dart';
import 'package:debtbook/features/auth/presentation/components/google_sign_in_button.dart';
import 'package:debtbook/features/auth/presentation/components/my_button.dart';
import 'package:debtbook/themes/blocs/bloc/switch_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (_isLogin) {
      context.read<AuthBloc>().add(
        AuthLogInRequested(email: email, password: password),
      );
    } else {
      context.read<AuthBloc>().add(
        AuthRegisterRequested(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(_isLogin ? 'Log in' : 'Create an account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
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

              const SizedBox(height: 12),

              // email field
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // password field
              TextFormField(
                controller: _passwordCtrl,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Minimum 6 chars';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // login / Sign up
              MyButton(onTap: _submit, text: _isLogin ? 'Login' : 'Sign Up'),

              // oath sign (apple + google)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // apple button
                  MyAppleSignInButton(onTap: () {}),

                  SizedBox(width: 10),

                  // google button
                  MyGoogleSignInButton(onTap: () {}),
                ],
              ),

              // Row "Don't have an account ?"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? "Don't have an account ?" : 'Already a member ?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin ? "Let's register" : "Login now ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
