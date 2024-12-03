import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_it/auth/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // دالة للتحقق من صحة البريد الإلكتروني الجامعي
  bool isUniversityEmail(String email) {
    // تعبير منتظم للتحقق من البريد الإلكتروني
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@it\.misuratau\.edu\.ly$');
    return regex.hasMatch(email);
  }

  // دالة التسجيل باستخدام Firebase
  Future<void> signUpWithEmailPassword() async {
    // تحقق من أن البريد الإلكتروني يتبع النطاق الجامعي الصحيح
    if (!isUniversityEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("يرجى استخدام عنوان البريد الإلكتروني الخاص بالجامعة."),
          backgroundColor: Colors.red));
      return; // إيقاف التسجيل إذا كان البريد الإلكتروني غير صحيح
    }

    try {
      // محاولة إنشاء الحساب باستخدام البريد الإلكتروني وكلمة المرور
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // يمكنك هنا إضافة المزيد من المعلومات للمستخدم في Firebase مثل الاسم
      await userCredential.user?.updateDisplayName(
        "${_firstNameController.text} ${_lastNameController.text}",
      );

      // بعد نجاح التسجيل، التنقل إلى الصفحة الرئيسية أو شاشة أخرى
      Get.to(() => LoginScreen()); // استبدل Placeholder بشاشة التطبيق الرئيسية
    } catch (e) {
      print("Error: $e");
      // عرض خطأ إذا فشل التسجيل
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("فشل في التسجيل. يرجى المحاولة مرة أخرى."),
          backgroundColor: Colors.red));
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "images/itel.PNG", // ضع شعارك هنا
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "IT Electronic Library",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "انطلق في عالم المعرفة مع مكتبتنا!",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "الاسم الاول",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: "اسم العائلة",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "عنوان البريد الإلكتروني",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "كلمة السر",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              color: const Color(0xFF0F99AC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: signUpWithEmailPassword,
              child: const Text(
                "انشاء",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
