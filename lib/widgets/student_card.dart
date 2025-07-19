import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  StudentCard({required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(student.name[0])),
        title: Text(student.name),
        subtitle: Text('Mã SV: ${student.id}'),
      ),
    );
  }
}