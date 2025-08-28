import 'package:flutter/material.dart';
import '../models/student.dart';

class DeleteStudentPage extends StatefulWidget {
  final List<Student> students;

  const DeleteStudentPage({super.key, required this.students});

  @override
  State<DeleteStudentPage> createState() => _DeleteStudentPageState();
}

class _DeleteStudentPageState extends State<DeleteStudentPage> {
  final TextEditingController _idController = TextEditingController();
  String _message = "";

  void _deleteStudent() {
    String id = _idController.text.trim();
    if (id.isEmpty) {
      setState(() {
        _message = "Vui lòng nhập số báo danh";
      });
      return;
    }

    final studentIndex =
    widget.students.indexWhere((student) => student.id == id);

    if (studentIndex != -1) {
      setState(() {
        widget.students.removeAt(studentIndex);
        _message = "✅ Đã xoá sinh viên có số báo danh $id";
      });
    } else {
      setState(() {
        _message = "❌ Không tìm thấy sinh viên có số báo danh $id";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Xoá sinh viên")),
      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: "Nhập số báo danh",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Xoá"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _deleteStudent,
                ),
                SizedBox(height: 20),
                Text(
                  _message,
                  style: TextStyle(
                    fontSize: 16,
                    color: _message.startsWith("✅") ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}