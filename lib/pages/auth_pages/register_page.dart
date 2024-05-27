import 'package:email_otp/email_otp.dart';
import 'package:firebase_learning_part2/models/user_model.dart';

import 'package:firebase_learning_part2/pages/auth_pages/check_email_page.dart';
import 'package:firebase_learning_part2/pages/auth_pages/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController surnameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  EmailOTP myAuth = EmailOTP();

  Future<void> checkFilling() async {
    if (nameC.text.length <= 2 || surnameC.text.length <= 2) {
      Utils.fireSnackBar("Name or Surname is not filled right", context);
    } else if (!emailC.text.endsWith("@gmail.com") ||
        emailC.text.length <= 11) {
      Utils.fireSnackBar("email is not filled right", context);
    } else if (passwordC == confirmC || passwordC.text.length <= 7) {
      Utils.fireSnackBar("Password is not filled true", context);
    } else if (phoneC.text.length != 9) {
      Utils.fireSnackBar("Phone length must be 9 numbers", context);
    } else {
      myAuth.setConfig(
          appEmail: "abdulloibrohimov3@gmail.com",
          appName: "Little project",
          userEmail: emailC.text.trim(),
          otpLength: 6,
          otpType: OTPType.digitsOnly);
      if (await myAuth.sendOTP() == true) {
        Utils.fireSnackBarTrue("We send code to your email", context);
        UserModel model = UserModel(password: passwordC.text, phoneNumber: phoneC.text, fullName: "${nameC.text}/${surnameC.text}", email: emailC.text, avatar: "",id: "");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckEmailPage(
                      auth: myAuth,
                    infoFirstPage: model,
                  fullNameOff: model.fullName!
                    )));
      } else {
        print("\n\nnot worked\n\n");
      }



    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Registration Menu",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Colors.black87,
                      fontFamily: ""),
                ),
                const SizedBox(
                  height: 71,
                ),
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                      labelText: "Your Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: surnameC,
                  decoration: InputDecoration(
                      labelText: "Your Surname",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 20,
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
                  controller: phoneC,
                  decoration: InputDecoration(
                    prefixText: "+998 ",
                      labelText: "Your Phone Number",
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
                  height: 20,
                ),
                TextField(
                  controller: confirmC,
                  decoration: InputDecoration(
                      labelText: "Confirm the password",
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
                      "Next",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "I already have an account",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

sealed class Utils {
  // FireSnackBar
  static void fireSnackBar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade400.withOpacity(0.975),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 2500),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
      ),
    );
  }

  static void fireSnackBarTrue(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withOpacity(0.975),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 2500),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder(),
      ),
    );
  }
}
