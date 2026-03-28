import 'package:debtbook/features/auth/data/firebase_auth_repo.dart';
import 'package:debtbook/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:debtbook/features/home/presentation/pages/home_page.dart';
import 'package:debtbook/themes/app_theme.dart';
import 'package:debtbook/themes/blocs/bloc/switch_theme_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Hydrated storage build
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  // run app
  runApp(const MyApp());
}

// My app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // auth repo initilise
    final authRepository = FirebaseAuthRepo();

    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: authRepository)],
      child: MultiBlocProvider(
        providers: [
          // auth bloc
          BlocProvider<AuthBloc>(
            create:
                (context) =>
                    AuthBloc(authRepository: authRepository)
                      ..add(AuthCheckRequested()),
          ),
          // theme bloc
          BlocProvider<SwitchThemeBloc>(create: (context) => SwitchThemeBloc()),
        ],
        child: BlocBuilder<SwitchThemeBloc, SwitchThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme:
                  state.switchValue
                      ? AppThemes.appThemeData[AppTheme.darkMode]
                      : AppThemes.appThemeData[AppTheme.lightMode],
              home: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
