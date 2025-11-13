import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import '../models/patient.dart';

class NewPatientScreen extends StatefulWidget {
  const NewPatientScreen({Key? key}) : super(key: key);

  @override
  _NewPatientScreenState createState() => _NewPatientScreenState();
}

class _NewPatientScreenState extends State<NewPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  DateTime? _appointmentDate;
  TimeOfDay? _appointmentTime;
  String _gender = 'Male';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _appointmentDate ?? now,
      firstDate: now.subtract(Duration(days: 365)),
      lastDate: now.add(Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _appointmentDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _appointmentTime ?? TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _appointmentTime = picked);
  }

  String _formatAppointment() {
    if (_appointmentDate == null && _appointmentTime == null) return '—';
    final dateStr = _appointmentDate != null ? DateFormat.yMMMd().format(_appointmentDate!) : '';
    final timeStr = _appointmentTime != null ? _appointmentTime!.format(context) : '';
    return [dateStr, timeStr].where((s) => s.isNotEmpty).join(' • ');
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final patient = Patient(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      age: int.parse(_ageCtrl.text.trim()),
      gender: _gender,
      appointment: _formatAppointment(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Patient Saved'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${patient.name}'),
            SizedBox(height: 6),
            Text('Phone: ${patient.phone}'),
            SizedBox(height: 6),
            Text('Age/Gender: ${patient.age} / ${patient.gender}'),
            SizedBox(height: 6),
            Text('Appointment: ${patient.appointment}'),
          ],
        ),
        actions: [TextButton(onPressed: () { Navigator.of(context).pop(); Navigator.of(context).pop(); }, child: Text('OK'))],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final brand = Brand.primary;
    return Scaffold(
      appBar: AppBar(title: Text('New Patient')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Appointment', style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickDate,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black87),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(_appointmentDate != null ? DateFormat.yMMMMd().format(_appointmentDate!) : 'Pick date'),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickTime,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black87),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(_appointmentTime != null ? _appointmentTime!.format(context) : 'Pick time'),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 18),

              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: 'Full name', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                validator: (v) => v == null || v.trim().isEmpty ? 'Please enter a name' : null,
              ),

              SizedBox(height: 12),

              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone number', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Please enter phone number';
                  if (v.trim().length < 7) return 'Enter a valid phone';
                  return null;
                },
              ),

              SizedBox(height: 12),

              TextFormField(
                controller: _addressCtrl,
                decoration: InputDecoration(labelText: 'Address', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                maxLines: 2,
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Age', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Enter age';
                        final n = int.tryParse(v.trim());
                        if (n == null || n <= 0) return 'Enter valid age';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _gender,
                      items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                      onChanged: (v) => setState(() => _gender = v ?? 'Male'),
                      decoration: InputDecoration(labelText: 'Gender', filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(backgroundColor: brand, padding: EdgeInsets.symmetric(vertical: 14)),
                  child: Text('Save Patient', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
