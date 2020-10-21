import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  StorageUploadTask storageUploadTask;
  StorageTaskSnapshot taskSnapshot;

  StorageProvider() {
    print('Firebase Storage has been initialized');
  }

  Future<String> startUpload(File file, String uid) async {
    try {
      /// Unique file name for the file
      String filePath = 'profile/$uid/dp.png';
      //Create a storage reference
      StorageReference reference =
          FirebaseStorage.instance.ref().child(filePath);
      //Create a task that will handle the upload
      storageUploadTask = reference.putFile(
        file,
      );
      taskSnapshot = await storageUploadTask.onComplete;
      String urlResult = await taskSnapshot.ref.getDownloadURL();
      return urlResult;
    } catch (e) {
      print('startUpload ERROR -> ${e.toString()}');
      return null;
    }
  }
}
