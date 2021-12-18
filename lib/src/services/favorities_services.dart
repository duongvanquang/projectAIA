import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiFavorities {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('favorities');
  Future<void> favorities(
      final String? userName,
      final String? fullName,
      final String? type,
      final int? moviesId,
      final String? moviesName,
      final String? imagePath,
      final String? dataTimeCreated) async {
    final user = auth.currentUser;
    return recipeCollection.doc().set({
      'author': user?.email,
      'fullName': fullName,
      'type': type,
      'moviesId': moviesId,
      'moviesName': moviesName,
      'imagePath': imagePath,
      'dataTimeCreated': dataTimeCreated
    });
  }
}
