import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class EditStudentPage extends StatefulWidget {
  const EditStudentPage({super.key});

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();

  Student? _student; // sinh viên được tìm thấy

  void _findStudent() {
    final id = _idController.text.trim();
    final student = StudentService.students.firstWhere(
          (s) => s.id == id,
      orElse: () => Student(id: '', name: '', className: ''),
    );

    if (student.id.isNotEmpty) {
      setState(() {
        _student = student;
        _nameController.text = student.name;
        _classController.text = student.className;
      });
    } else {
      setState(() {
        _student = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không tìm thấy sinh viên")),
      );
    }
  }

  void _saveChanges() {
    if (_student != null) {
      setState(() {
        _student!.name = _nameController.text.trim();
        _student!.className = _classController.text.trim();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thành công")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa sinh viên"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Ảnh nền
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Nội dung
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: "Nhập mã số sinh viên",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _findStudent,
                  child: const Text("Tìm sinh viên"),
                ),
                const SizedBox(height: 20),

                if (_student != null) ...[
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Tên sinh viên",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      labelText: "Lớp",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Lưu thay đổi"),
                    onPressed: _saveChanges,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}