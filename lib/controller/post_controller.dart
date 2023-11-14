import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:healthscanpro/const/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:path/path.dart';

class PostController extends GetxController {
  var imageUploaded = false.obs;
  storePostData({text, imageurl}) async {
    DocumentReference store =
        firestore.collection("Posts").doc(currentuser!.uid);
    var postId = const Uuid().v4();
    var commentId = const Uuid().v4();
    store.set({
      'text': text,
      'image_url': imageurl ?? '',
      'dateTime': DateTime.now(),
      'user_id': currentuser!.uid,
      'post_id': postId,
      'Likes': '',
      'CommentId': commentId,
    });
    isloading(false);
  }

  var profileImgPath = ''.obs;
  var profileImagelink = "";
  var isloading = false.obs;

  //textfield

  var postTextController = TextEditingController();

  selectImage(context) async {
    await Permission.storage.request();
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (status.isGranted) {
      VxToast.show(context, msg: "Permission Denied");
    } else {
      try {
        final img = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 95);

        if (img == null) return;
        profileImgPath.value = img.path;

        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    }
  }

  uplaodProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = "postimages/${currentuser!.uid}/filename";
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImagelink = await ref.getDownloadURL();
  }

  // updatePost({name, password, imgUrl}) async {
  //   var store = firestore.collection(usersCollection).doc(currentuser!.uid);
  //   await store.set({'name': name, 'password': password, 'image_url': imgUrl},
  //       SetOptions(merge: true));
  //   isloading(false);
  // }
}
