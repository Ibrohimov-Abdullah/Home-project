import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learning_part2/pages/auth_pages/register_page.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> checkFilling() async {
    User? user = await AuthService.loginUser(context, email: emailC.text, password: passwordC.text);

    if(user != null) {
      Utils.fireSnackBarTrue("Successfully Loged-in", context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
    }else{
      Utils.fireSnackBar("Email or Password is wrong", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Login Menu",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.black87,
                    fontFamily: ""),
              ),
              const SizedBox(
                height: 100,
              ),
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                    labelText: "Your Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordC,
                decoration: InputDecoration(
                    labelText: "Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  height: 70,
                  minWidth: double.infinity,
                  color: Colors.blue,
                  splashColor: Colors.blue,
                  onPressed: checkFilling,
                  child: const Text(
                    "Sign-in",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
