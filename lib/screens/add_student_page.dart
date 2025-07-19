import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
      );
      StudentService.addStudent(newStudent);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm sinh viên')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Mã số sinh viên'),
                validator: (value) => value!.isEmpty ? 'Nhập mã sinh viên' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Họ và tên'),
                validator: (value) => value!.isEmpty ? 'Nhập họ tên' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Lưu'),
              )
            ],
          ),
        ),
      ),
    );
  }
}