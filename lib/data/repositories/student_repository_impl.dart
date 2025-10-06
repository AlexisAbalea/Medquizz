import 'package:medquizz_pass/data/datasources/database_helper.dart';
import 'package:medquizz_pass/data/models/student_model.dart';
import 'package:medquizz_pass/domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final DatabaseHelper _dbHelper;

  StudentRepositoryImpl(this._dbHelper);

  @override
  Future<StudentModel?> getCurrentStudent() async {
    final students = await _dbHelper.queryAll('students');
    if (students.isEmpty) return null;
    return StudentModel.fromMap(students.first);
  }

  @override
  Future<int> createStudent(StudentModel student) async {
    return await _dbHelper.insert('students', student.toMap());
  }

  @override
  Future<void> updateStudent(StudentModel student) async {
    if (student.id == null) {
      throw Exception('Student ID cannot be null for update');
    }
    await _dbHelper.update(
      'students',
      student.toMap(),
      'id = ?',
      [student.id],
    );
  }

  @override
  Future<void> deleteStudent(int id) async {
    await _dbHelper.delete('students', 'id = ?', [id]);
  }

  @override
  Future<bool> hasStudent() async {
    final students = await _dbHelper.queryAll('students');
    return students.isNotEmpty;
  }
}
