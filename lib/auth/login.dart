import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signInWithGoogle() async {
    try {
      // تسجيل الدخول باستخدام Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // إذا تم إلغاء تسجيل الدخول من قبل المستخدم
        return;
      }

      // الحصول على المصادقة من Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // التحقق من نطاق البريد الإلكتروني
      final email = googleUser.email;
      if (!email.endsWith('@it.misuratau.edu.ly')) {
        // عرض رسالة خطأ إذا كان النطاق غير مطابق
        showError("يجب استخدام بريد إلكتروني تابع للنطاق @it.misuratau.edu.ly");
        return;
      }

      // متابعة المصادقة إذا كان البريد الإلكتروني صحيحًا
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      // عرض رسالة نجاح أو الانتقال إلى الشاشة الرئيسية بعد نجاح تسجيل الدخول
      print("Login successful!");
    } catch (e) {
      // التعامل مع الأخطاء أثناء عملية تسجيل الدخول
      showError("حدث خطأ أثناء تسجيل الدخول: $e");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30),
      child: ListView(children: [
        Column(children: [
          Container(height: 150),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "images/itel.PNG",
                width: 200,
                height: 200,
              )),
          Container(height: 20), // Column
          const Text(
            "Login",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(height: 10),
          const Text(
            "Login To Continue Using The App",
            style: TextStyle(color: Colors.grey),
          ),
          Container(height: 20),
          Container(height: 20),
        ]),
        MaterialButton(
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.orange,
            textColor: Colors.white,
            onPressed: () {
              signInWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/google.PNG",
                  width: 40,
                  height: 40,
                ),
                const Text("  Login With Google")
              ],
            ))
      ]),
    ));
  }
}
