import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_it/auth/login.dart';
import 'package:project_it/main_screen.dart';
import 'package:project_it/add_screen.dart'; // صفحة الإضافة

class Authuntication extends StatelessWidget {
  const Authuntication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // الحصول على المستخدم الحالي
            final User? user = FirebaseAuth.instance.currentUser;

            // التحقق من البريد الإلكتروني
            if (user?.email == 'admin@admin.com') {
              // توجيه المستخدم إذا كان المدير
              return const AddScreen(); // صفحة الإضافة
            } else {
              // توجيه المستخدم إذا كان مستخدم عادي
              return const MineScreen(); // صفحة "الهوم"
            }
          } else {
            return LoginScreen(); // صفحة تسجيل الدخول
          }
        },
      ),
    );
  }
}
