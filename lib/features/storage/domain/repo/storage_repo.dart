import 'dart:typed_data';

abstract class StorageRepo{
  Future<String?> uploadProfileMobile(String path,String fileName);
  Future<String?> uploadProfileWeb(Uint8List fileBytes,String fileName);


}