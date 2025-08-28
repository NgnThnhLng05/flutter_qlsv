import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  final _classController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _classController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      // kiểm tra trùng mã
      final exists = StudentService.students.any(
            (s) => s.id.toLowerCase() == _idController.text.trim().toLowerCase(),
      );
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mã số sinh viên đã tồn tại!'), backgroundColor: Colors.red),
        );
        return;
      }

      final newStudent = Student(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        className: _classController.text.trim(),
      );
      StudentService.addStudent(newStudent);
      Navigator.pop(context);
    }
  }

  // Tạo dữ liệu JSON để nhúng vào QR
  String _buildQrPayload() {
    final data = {
      'id': _idController.text.trim(),
      'name': _nameController.text.trim(),
      'className': _classController.text.trim(),
      'type': 'student_form' // tag để nhận diện đúng loại QR
    };
    return jsonEncode(data);
  }

  // Hiển thị QR dưới dạng dialog
  void _showQrDialog() {
    if (!_formKey.currentState!.validate()) {
      // bắt buộc nhập đủ rồi mới tạo QR cho khỏi rác dữ liệu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập đầy đủ trước khi tạo QR')),
      );
      return;
    }
    final payload = _buildQrPayload();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('QR thông tin sinh viên'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: payload,
              version: QrVersions.auto,
              size: 240,
            ),
            SizedBox(height: 8),
            Text('Dùng điện thoại khác quét để tự điền.'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Đóng')),
        ],
      ),
    );
  }

  // Mở màn hình quét QR
  Future<void> _scanQrAndFill() async {
    final result = await Navigator.push<Map<String, dynamic>?>(
      context,
      MaterialPageRoute(builder: (_) => ScanQrPage()),
    );
    if (result != null) {
      // kiểm tra type
      if (result['type'] == 'student_form') {
        setState(() {
          _idController.text = (result['id'] ?? '').toString();
          _nameController.text = (result['name'] ?? '').toString();
          _classController.text = (result['className'] ?? '').toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã nhập dữ liệu từ QR')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR không đúng định dạng')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm sinh viên')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'Mã số sinh viên',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value!.trim().isEmpty ? 'Nhập mã sinh viên' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value!.trim().isEmpty ? 'Nhập họ tên' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _classController,
                    decoration: InputDecoration(
                      labelText: 'Lớp',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value!.trim().isEmpty ? 'Nhập lớp' : null,
                  ),
                  SizedBox(height: 20),

                  // Hàng nút thao tác
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _showQrDialog,
                          child: Text('Tạo QR'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _scanQrAndFill,
                          child: Text('Quét QR'),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveStudent,
                    child: Text('Lưu'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Màn hình quét QR
class ScanQrPage extends StatefulWidget {
  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  bool _handled = false; // tránh đọc nhiều lần

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quét mã QR')),
      body: MobileScanner(
        onDetect: (capture) {
          if (_handled) return;
          final barcodes = capture.barcodes;
          if (barcodes.isEmpty) return;

          final raw = barcodes.first.rawValue ?? '';
          try {
            final map = jsonDecode(raw);
            _handled = true;
            Navigator.pop<Map<String, dynamic>>(context, Map<String, dynamic>.from(map));
          } catch (_) {
            // Không phải JSON hợp lệ → trả về null để báo lỗi phía trên
            _handled = true;
            Navigator.pop<Map<String, dynamic>?>(context, null);
          }
        },
      ),
    );
  }
}