/*

Auth Repository - Outlines the possibles auth operations for this app. 

*/

import 'package:debtbook/features/auth/domain/models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  Future<AppUser?> registerWithEmailPassword(String email, String password);

  Future<void> logout();

  Future<AppUser?> getCurrentUser();
}
