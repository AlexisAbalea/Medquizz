import 'package:flutter/foundation.dart';
import 'package:medquizz_pass/data/models/student_model.dart';
import 'package:medquizz_pass/domain/repositories/student_repository.dart';

class StudentProvider with ChangeNotifier {
  final StudentRepository _repository;

  StudentModel? _currentStudent;
  bool _isLoading = false;
  String? _error;

  StudentProvider(this._repository);

  StudentModel? get currentStudent => _currentStudent;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasStudent => _currentStudent != null;

  Future<void> loadCurrentStudent() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentStudent = await _repository.getCurrentStudent();
    } catch (e) {
      _error = 'Erreur lors du chargement du profil: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createStudent(String name, String yearLevel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final student = StudentModel(
        name: name,
        yearLevel: yearLevel,
        createdAt: DateTime.now(),
      );

      final id = await _repository.createStudent(student);
      _currentStudent = student.copyWith(id: id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de la création du profil: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStudent(String name, String yearLevel) async {
    if (_currentStudent == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedStudent = _currentStudent!.copyWith(
        name: name,
        yearLevel: yearLevel,
      );

      await _repository.updateStudent(updatedStudent);
      _currentStudent = updatedStudent;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de la mise à jour du profil: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteStudent() async {
    if (_currentStudent?.id == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteStudent(_currentStudent!.id!);
      _currentStudent = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Erreur lors de la suppression du profil: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> checkIfHasStudent() async {
    try {
      return await _repository.hasStudent();
    } catch (e) {
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
