import 'dart:developer';
import 'dart:io';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_learning_part2/models/user_model.dart';
import 'package:firebase_learning_part2/pages/auth_pages/register_page.dart';
import 'package:firebase_learning_part2/pages/auth_pages/upload_photo_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({super.key, required this.auth, required this.infoFirstPage, required this.fullNameOff});
  final EmailOTP auth;
  final UserModel infoFirstPage;
  final String fullNameOff;
  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {

  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify your email"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),

          MaterialButton(
            color: Colors.amber,
            onPressed: ()async{
              if(widget.auth.verifyOTP(otp: passController.text) == true){
                log("nicee");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("emailKey", widget.infoFirstPage.email!);
                Utils.fireSnackBarTrue("Password is correct", context);
                log(widget.fullNameOff);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadPhotoPage(infoSecondPage: widget.infoFirstPage,fullNameUser: widget.fullNameOff,)));
              }else{
                Utils.fireSnackBar("password is not right\nPlease try again", context);
              }
            },
            child: const Text("Next")
          )
        ],
      ),
    );
  }
}
