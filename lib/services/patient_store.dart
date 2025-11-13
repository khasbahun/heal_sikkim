
import '../models/patient.dart';

class PatientStore {
  PatientStore._privateConstructor();
  static final PatientStore instance = PatientStore._privateConstructor();

  final List<Patient> _patients = [];

  List<Patient> getAll() => List.unmodifiable(_patients);

  void add(Patient p) {
    _patients.add(p);
    // keep list sorted alphabetically by name
    _patients.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  void clear() => _patients.clear();
}