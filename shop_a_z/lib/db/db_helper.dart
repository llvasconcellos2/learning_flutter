import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionAdmin = 'Admins';

  static Future<bool> isAdmin(String uid) async {
    final doc = await _db.collection(collectionAdmin).doc(uid).get();
    return doc.exists;
  }
}
