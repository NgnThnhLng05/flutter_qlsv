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
    final students = StudentService.students;

    return Scaffold(
      appBar: AppBar(title: Text('Danh sách sinh viên')),
      body: students.isEmpty
          ? Center(child: Text('Chưa có sinh viên nào.'))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentCard(student: students[index]);
        },
      ),
    );
  }
}