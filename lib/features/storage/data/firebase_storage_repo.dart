import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../domain/repo/storage_repo.dart';


class FirebaseStorageRepo implements StorageRepo{
  final FirebaseStorage storage=FirebaseStorage.instance;

  @override
  Future<String?> uploadProfileMobile(String path, String fileName){
    return uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileWeb(Uint8List fileBytes, String fileName) {
   return uploadFieBytes(fileBytes, fileName, "profile_images");
  }

  Future<String?> uploadFile(String path,String fileName, String folder) async{
   try{
     final file=File(path);

     final storageRef=storage.ref().child('$folder/$fileName');

     final uploadFile=await storageRef.putFile(file);

     final downloadUrl=await uploadFile.ref.getDownloadURL();
     return downloadUrl;
   }catch(e){
    return null;
   }

  }
  Future<String?> uploadFieBytes(Uint8List fileBytes,String fileName,String folder) async{
    try{
      final storageRef=storage.ref().child('$folder/$fileName');

      final uploadFile=await storageRef.putData(fileBytes);

      final downloadUrl=await uploadFile.ref.getDownloadURL();
      return downloadUrl;
    }catch(e){
      return null;
    }
  }
}