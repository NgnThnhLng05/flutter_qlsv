import 'package:flutter/material.dart';
import 'add_student_page.dart';
import 'student_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar vẫn giữ nguyên
      appBar: AppBar(
        title: Text('Quản lý Sinh viên'),
        centerTitle: true,
      ),
      // Stack giúp đặt ảnh nền dưới và nội dung ở trên
      body: Stack(
        children: [
          // Ảnh nền
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nội dung trên nền
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.list),
                  label: Text('Danh sách sinh viên'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentListPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.person_add),
                  label: Text('Thêm sinh viên'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddStudentPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
