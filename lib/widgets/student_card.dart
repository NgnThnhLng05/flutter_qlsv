import 'package:flutter/material.dart';
import '../models/student.dart';
import '../screens/student_detail_page.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(student.name),
        subtitle: Text('Mã số: ${student.id}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDetailPage(student: student),
            ),
          );
        },
      ),
    );
  }
}