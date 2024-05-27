import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  File? _image;
  String name = "";
  Future<void> read() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString("emailKey")??"No name";

    final base64String = prefs.getString('saved_image');

    if (base64String != null) {
      final bytes = base64Decode(base64String);
      setState(() {
        _image = File.fromRawPath(bytes);
      });
    }
  }

  double height = 20;

  @override
  void initState() {
    read();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              await AuthService.logoutUser();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: ()async{
              await AuthService.deleteUser();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.user?.displayName ?? "NO name"),
            Text(widget.user?.email ?? "no Email"),
            Text(widget.user?.phoneNumber ??"null"),
            const SizedBox(height: 40,),
            MaterialButton(onPressed: (){
              setState(() {
                height = double.infinity;
              });
            }, color: Colors.orange, child: const Text("crash 1"),),
            MaterialButton(onPressed: (){}, color: Colors.orange, child: const Text("crash 2"),),
            MaterialButton(onPressed: (){}, color: Colors.orange, child: const Text("crash 3"),),
            MaterialButton(onPressed: (){}, color: Colors.orange, child: const Text("crash 4"),),
            SizedBox(height: height,),
            _image != null ? CircleAvatar(
              foregroundImage: Image.file(_image!).image,
            ) : const Text("No image set")
          ],
        ),
      ),
    );
  }
}
