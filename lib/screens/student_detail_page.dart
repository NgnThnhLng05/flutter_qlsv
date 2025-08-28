import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentDetailPage extends StatelessWidget {
  final Student student;

  const StudentDetailPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ảnh nền phủ toàn bộ kể cả AppBar
        Positioned.fill(
          child: Image.asset(
            'lib/assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // Scaffold trong suốt để AppBar nổi trên ảnh
        Scaffold(
          backgroundColor: Colors.transparent, // để ảnh xuyên qua
          appBar: AppBar(
            title: Text('Chi tiết thông tin sinh viên'),
            backgroundColor: Colors.white30,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên: ${student.name}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 12),
                Text('Mã số: ${student.id}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 12),
                Text('Lớp: ${student.className}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}