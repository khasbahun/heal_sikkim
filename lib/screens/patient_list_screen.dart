// lib/screens/patient_list_screen.dart
import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/patient_store.dart';
import '../utils/constants.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<Patient> _display = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _searchCtrl.addListener(_onSearch);
  }

  void _loadPatients() {
    _display = PatientStore.instance.getAll();
    setState(() {});
  }

  void _onSearch() {
    final q = _searchCtrl.text.trim().toLowerCase();
    final all = PatientStore.instance.getAll();
    if (q.isEmpty) {
      _display = all;
    } else {
      _display = all.where((p) =>
        p.name.toLowerCase().contains(q) ||
        p.phone.toLowerCase().contains(q)
      ).toList();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearch);
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
        backgroundColor: Brand.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search by name or phone',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          Expanded(
            child: _display.isEmpty
              ? Center(child: Text('No patients yet. Add from New Patient.'))
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final p = _display[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Brand.primary.withOpacity(0.12),
                        child: Text(p.name.isNotEmpty ? p.name[0].toUpperCase() : '?', style: TextStyle(color: Brand.primary)),
                      ),
                      title: Text(p.name),
                      subtitle: Text(p.appointment == '—' ? '${p.phone} • ${p.age} yrs' : '${p.appointment} • ${p.phone}'),
                      trailing: Icon(Icons.chevron_right, color: Colors.black26),
                      onTap: () {
                        // optional: show details or edit. For now, show simple dialog
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: Text(p.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone: ${p.phone}'),
                              SizedBox(height: 6),
                              Text('Age/Gender: ${p.age} / ${p.gender}'),
                              SizedBox(height: 6),
                              Text('Address: ${p.address}'),
                              SizedBox(height: 6),
                              Text('Appointment: ${p.appointment}'),
                            ],
                          ),
                          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close'))],
                        ));
                      },
                    );
                  },
                  separatorBuilder: (_, __) => Divider(height: 1),
                  itemCount: _display.length,
                ),
          ),
        ],
      ),
    );
  }
}
