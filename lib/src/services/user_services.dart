import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../enum/enums_firebase.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firesstore = FirebaseFirestore.instance;
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return FirebaseCode.loginSuccess.code;
    } on FirebaseException catch (exception) {
      return exception.code;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final sigin = authResult.user;
      if (sigin != null) {
        await _firesstore
            .collection('users')
            .doc(sigin.email)
            .set({'email': email});
      }
      return FirebaseCode.signUpSuccess.code;
    } on FirebaseException catch (exception) {
      return exception.code;
    }
  }
}
