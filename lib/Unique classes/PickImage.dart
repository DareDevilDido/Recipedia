import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipedia/Constants/Constants.dart';

class PickImage extends ChangeNotifier {
  PlatformFile? image;

  Future<PlatformFile> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    image = result?.files.first;
    notifyListeners();
    return image!;
  }

  Future<String> uploadFile() async {
    final path = "UserIngredients/$kUserId/${image!.name}";
    final files = File(image!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadtasks = ref.putFile(files);

    final snapshot = await uploadtasks.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<String> uploadRecipeFile() async {
    final path = "UserRecipes/$kUserId/${image!.name}";
    final files = File(image!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    var uploadtasks = ref.putFile(files);

    final snapshot = await uploadtasks.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}

// Provider.of<PickImage>(context).selectFile(),

// onPressed: () {
// Provider.of<PickImage>(context, listen: false).selectFile();
// })
