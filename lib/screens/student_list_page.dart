import 'package:flutter/material.dart';
import '../services/student_service.dart';
import '../widgets/student_card.dart';

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách sinh viên')),
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Nội dung danh sách
          StudentService.students.isEmpty
              ? Center(
            child: Text(
              'Chưa có sinh viên nào!',
              style: TextStyle(color: Colors.white),
            ),
          )
              : RefreshIndicator(
            // cho phép vuốt xuống để refresh danh sách
            onRefresh: () async {
              setState(() {}); // cập nhật lại khi có thay đổi
            },
            child: ListView.builder(
              itemCount: StudentService.students.length,
              itemBuilder: (context, index) {
                return StudentCard(student: StudentService.students[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}