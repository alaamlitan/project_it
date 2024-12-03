import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_it/main_screen.dart'; // استيراد الشاشة الجديدة

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //يتم اضافة دالة بنفس الاسم يلي انشاءته في اون تاب
  Future signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _emailController.text.trim(),
    );
  }

// يتم استخدام ديبوز ليتم التعطيل الكترول اءا لا يتم استحدامها
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  // دالة للتحقق من البريد الإلكتروني الجامعي
  bool isValidUniversityEmail(String email) {
    return email.endsWith('@it.misuratau.edu.ly'); // تحقق من البريد الجامعي
  }

  void signInWithEmailPassword(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // التحقق من الحقول الفارغة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء إدخال كل من البريد الإلكتروني وكلمة المرور."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!isValidUniversityEmail(email)) {
      // التحقق من صحة البريد الإلكتروني الجامعي
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Please use a valid university email (e.g., @it.misuratau.edu.ly)."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (password.length < 6) {
      // التحقق من طول كلمة المرور
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 6 characters long."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // التنقل إلى MineScreen إذا كانت المدخلات صحيحة
      Get.to(() => const MineScreen());
    }
  }

  void signUpWithEmailPassword() {
    // منطق التسجيل
    print("Sign Up clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "images/itel.PNG", // ضع مسار صورتك هنا
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
                    "تسجيل الدخول أو الاشتراك",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 30),
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "هل نسيت كلمة السر؟",
                    style: TextStyle(color: Colors.orange[800]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: signin,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 9, 17, 107),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text('تسجيل دخــول '),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              color: Colors.orange[800]?.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () {
                signUpWithEmailPassword();
              },
              child: const Text(
                "انشاء حساب",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
