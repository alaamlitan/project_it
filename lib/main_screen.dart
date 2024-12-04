import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScreenController());

    // الشاشات الخاصة بكل تصنيف
    final List<Widget> screens = [
      Center(
          child: Text("الرئيسية",
              style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.grey,
                  fontSize: 22))),
      Center(
          child: Text("كتب ومشاريع تخرج",
              style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.grey,
                  fontSize: 22))),
      Center(
          child: Text("المفضلة",
              style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.grey,
                  fontSize: 22))),
      Center(
          child: Text("التنزيلات",
              style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.grey,
                  fontSize: 22))),
      Center(
          child: Text("الحساب",
              style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.grey,
                  fontSize: 22))),
    ];

    return Obx(() => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 120,
            backgroundColor: Colors.orange[800],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage("images/itel.PNG"),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "IT Electronic Library",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          controller.filterItems(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 8),
                          hintText: "ابحث حسب العنوان...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: controller.isDarkMode.value
                                ? Colors.white70
                                : Colors.black54,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: controller.isDarkMode.value
                              ? Colors.grey[600]
                              : Colors.white,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Obx(() => Icon(
                            controller.isDarkMode.value
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.white,
                          )),
                      onPressed: controller.toggleTheme,
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Container(
            color: controller.isDarkMode.value
                ? Colors.grey[850] // تغيير الخلفية في الوضع الداكن فقط
                : Colors.white, // تغيير الخلفية في الوضع الفاتح فقط
            child: Obx(
              () => screens[controller.currentIndex.value],
            ),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                controller.changePage(index);
              },
              selectedItemColor:
                  Colors.orange[800], // تحديد لون الأيقونة المحددة
              unselectedItemColor:
                  Colors.grey, // تحديد لون الأيقونات غير المحددة
              backgroundColor: Colors.white, // لون خلفية شريط التنقل ثابتة
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30),
                  label: "الرئيسية",
                  tooltip: "الرئيسية",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book, size: 30),
                  label: "كتب ومشاريع تخرج",
                  tooltip: "كتب ومشاريع تخرج",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 30),
                  label: "المفضلة",
                  tooltip: "المفضلة",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.file_download, size: 30),
                  label: "التنزيلات",
                  tooltip: "التنزيلات",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 30),
                  label: "الحساب",
                  tooltip: "الحساب",
                ),
              ],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 14),
            ),
          ),
        ));
  }
}
class ScreenController extends GetxController {
  var currentIndex = 0.obs;
  var isDarkMode = false.obs;
  var filteredItems = [].obs;

  // تغيير الصفحة عند الضغط على الأيقونة
  void changePage(int index) {
    currentIndex.value = index;
  }

  // التبديل بين الوضع الداكن والفاتح
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
  }

  // فلترة العناصر بناءً على النص المدخل
  void filterItems(String query) {
    if (kDebugMode) {
      print("بحث عن: $query");
    }
  }
}
