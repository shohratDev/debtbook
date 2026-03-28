import 'package:debtbook/features/auth/domain/models/app_user.dart';
import 'package:debtbook/features/auth/domain/repos/auth_repos.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  /* 
   access to firebase 
  */
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      // attempt sign up - попробуйте зарегистрироваться
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          ); /* [userCredential] - учетные данные пользователя */

      // create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      // return user
      return user;

      // catch any errors..
    } catch (e) {
      throw Exception('________Register failed__________ $e');
    }
  }

  // SIGN IN / LOGIN:  Email and Password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // attempt sign in / попытка войти в учетную запись
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      /* [userCredential] - учетные данные пользователя */

      // create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      // return user
      return user;

      // catch any errors..
    } catch (e) {
      throw Exception('_________Login failed_______ $e');
    }
  }

  // Sign out / Logout
  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  // GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      // get current logged in user from firebase
      final firebaseUser = _auth.currentUser;

      // no user logged in..
      if (firebaseUser == null) {
        return null;
      }
      // logged in user exists
      return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
    } catch (e) {
      print("_______Connection Error to get data of current user__________ $e");
      // TODO Спросить у Муххаммеда правильно это ?
      // throw Exception('Connection Error');
      return null;
    }
  }
}
