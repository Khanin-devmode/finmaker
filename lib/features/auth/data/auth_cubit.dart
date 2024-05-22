import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(AuthInitial());

  void checkAuthStatus() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(AuthAuthenticated(res.user as User));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  void signOut() async {
    emit(AuthLoading());
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }
}
