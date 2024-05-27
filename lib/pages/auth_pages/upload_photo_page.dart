import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning_part2/models/user_model.dart';
import 'package:firebase_learning_part2/pages/auth_pages/register_page.dart';
import 'package:firebase_learning_part2/pages/home_page.dart';
import 'package:firebase_learning_part2/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';

class UploadPhotoPage extends StatefulWidget {
  const UploadPhotoPage({super.key, required this.infoSecondPage, required this.fullNameUser});
  final String fullNameUser;
  final UserModel infoSecondPage;

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? selectedImage;

  Future selectGalleryImage() async {
    Navigator.pop(context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
        selectedImage = File(image.path);
        _saveImage(selectedImage!);
        setState(() {});
    }
  }

  Future<void> _saveImage(File image) async {
    final bytes = await image.readAsBytes();
    final base64String = base64Encode(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_image', base64String);
  }


  Future takeCameraImage() async {
    Navigator.pop(context);
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  double height = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload your photo"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: const AssetImage("assets/images/img_2.png"),
              foregroundImage:
                  selectedImage != null ? FileImage(selectedImage!) : null,
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 200,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Chose the source",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: selectGalleryImage,
                                  child: const Text("Gallery")),
                              ElevatedButton(
                                  onPressed: takeCameraImage,
                                  child: const Text("Camera")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                minWidth: 310,
                height: 310,
                shape: const CircleBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                var modelSecondPage = widget.infoSecondPage;
                if (selectedImage != null) {
                log(widget.fullNameUser);
                  UserModel model = UserModel(
                      id: modelSecondPage.id,
                      avatar: selectedImage!.path,
                      email: modelSecondPage.email,
                      fullName: widget.fullNameUser,
                      phoneNumber: modelSecondPage.phoneNumber,
                      password: modelSecondPage.password
                  );
                  User? user = await AuthService.registerUser(context, fullName: widget.fullNameUser, email: modelSecondPage.email!, password: modelSecondPage.password!,);
                  String? result = await ClientService.post(api: ClientService.apiPostUser, data: model.toJson());
                  if(user != null && result != null){
                      Utils.fireSnackBarTrue("You Successfully registered", context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(user: user,)),
                              (route) => false);
                  }
                } else {
                  Utils.fireSnackBar("Please put the photo", context);
                }
              },
              color: Colors.amber,
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
