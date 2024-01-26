import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CFSService {
  static var id = TextEditingController();
  static var name = TextEditingController();
  static var phoneNumber = TextEditingController();
  static var address = TextEditingController();
  static var company = TextEditingController();
  static var fav = TextEditingController();
  static TextEditingController editName = TextEditingController();
  static TextEditingController editPhoneNumber = TextEditingController();
  static TextEditingController editAddress = TextEditingController();
  static TextEditingController editCompany = TextEditingController();

  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<DocumentReference<Map<String, dynamic>>> createCollection(
      {required String collectionPath,
      required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await db.collection(collectionPath).add(data);
    return documentReference;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAllData({
    required String collectionPath,
  }) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
    await db.collection(collectionPath).get().then((value) {
      for (var element in value.docs) {
        list.add(element);
      }
    });

    return list;
  }

  static Future<void> delete(
      {required String id, required String collectionPath}) async {
    db.collection(collectionPath).doc(id).delete();
  }

  static Future<void> updateContact(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> data}) {
    return db
        .collection(collectionPath)
        .doc(docId)
        .update(data)
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> updateLike(
      {required String collectionPath,
      required String docId,
      required bool data}) {
    return db
        .collection(collectionPath)
        .doc(docId)
        .update({'isFavorited': data})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
