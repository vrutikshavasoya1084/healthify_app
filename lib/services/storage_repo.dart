import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mental_health/services/firebase_service.dart';

import 'locator.dart';

class StorageRepo{
  FirebaseStorage storage= FirebaseStorage.instanceFor(bucket: "gs://mental-health-e175a.appspot.com");

  final FirebaseService _firebaseService = locator.get<FirebaseService>();

  Future<String> uploadFile(File file) async{
    var user = await _firebaseService.getUser();
    if(user == null) return '';
    var storageRef = storage.ref().child("user/profile/${user.uid}");
    var uploadTask = storageRef.putFile(file);
    return (await uploadTask).ref.getDownloadURL();
  }

  Future<String> getUserProfileImageDownloadUrl(String uid) {
    var storageRef = storage.ref().child("user/profile/$uid");
    return storageRef.getDownloadURL();
  }

}