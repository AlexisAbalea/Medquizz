import 'package:hippoquiz/data/models/student_model.dart';

abstract class StudentRepository {
  Future<StudentModel?> getCurrentStudent();
  Future<int> createStudent(StudentModel student);
  Future<void> updateStudent(StudentModel student);
  Future<void> deleteStudent(int id);
  Future<bool> hasStudent();
}
