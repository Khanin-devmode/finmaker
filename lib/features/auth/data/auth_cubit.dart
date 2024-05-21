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
    print('auth checking...');
    if (currentUser != null) {
      print('user authenticated');
      emit(AuthAuthenticated(currentUser.email!));
    } else {
      print('no user authenticated');
      emit(AuthUnauthenticated());
    }
  }

  void signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthAuthenticated(email));
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
