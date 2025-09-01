import '../models/student.dart';

class StudentService {
  static final List<Student> _students = [];

  static List<Student> get students => _students;

  static void addStudent(Student student) {
    _students.add(student);
  }

  static void removeStudent(Student student) {
    _students.remove(student);
  }
}