import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

    Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'User-not-found') {
        emit(LoginFailure(errMessage: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong password'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'Something went wrong'));
    }
  }


  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: 'There was an error please try again'));
    }
  }


  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    super.onChange(change);
  }
}
