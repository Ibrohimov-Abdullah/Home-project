import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> registerUser(BuildContext context, {required String fullName, required String email, required String password}) async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password,);
      if(userCredential.user != null){
        await userCredential.user!.updateDisplayName(fullName);
        await userCredential.user!.reload();
        User? updateUser = auth.currentUser;
        return updateUser;
      }else{
        return null;
      }
    }catch (e){
      log("\n\n Smth went wrong \nError: $e\n\n");
      return null;
    }
  }


  static Future<User?> loginUser(BuildContext context, {required String email, required String password}) async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        return userCredential.user;
      }else{
        return null;
      }
    }catch (e) {
      log("\n\n Smth went wrong in login User \nError: $e\n\n");
      return null;
    }
  }

  static Future<void> deleteUser() async{
    await auth.currentUser?.delete();
  }

  static Future<void> logoutUser() async{
    await auth.signOut();
  }
}