import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/large_tile.dart';
import 'new_patient_screen.dart';
import 'patient_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 14),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCard(context),
                    SizedBox(height: 20),
                    Text('What do you need?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 12),
                    _buildHomeTiles(context),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Brand.primary,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text('HS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Heal Sikkim', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                SizedBox(height: 2),
                Text('Physiotherapy Clinic', style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 13)),
              ],
            ),
          ),
          Icon(Icons.notifications_none, color: Colors.white.withOpacity(0.9)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final softTeal = Brand.accent;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 6))]),
      child: Row(children: [
        Container(
          width: 72,
          height: 72,
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(width: 72, height: 72, child: CircularProgressIndicator(value: 0.45, strokeWidth: 9, backgroundColor: softTeal, valueColor: AlwaysStoppedAnimation<Color>(Brand.primary))),
            Column(mainAxisSize: MainAxisSize.min, children: [Text('4', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)), Text('Today', style: TextStyle(fontSize: 11, color: Colors.black54))])
          ]),
        ),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Welcome, Dr. Arun Mishra', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)), SizedBox(height: 6), Row(children: [_smallStat('Completed', '2'), SizedBox(width: 8), _smallStat('Upcoming', '2')])]))
      ]),
    );
  }

  Widget _smallStat(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontSize: 11, color: Colors.black54)), SizedBox(height: 4), Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Brand.primary))]),
    );
  }

Widget _buildHomeTiles(BuildContext context) {
  final items = [
    {'label': 'New Patient', 'icon': Icons.person_add, 'action': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NewPatientScreen()))},
    {'label': 'Patient List', 'icon': Icons.people_outline, 'action': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PatientListScreen()))},
    {'label': 'Appointments', 'icon': Icons.calendar_today, 'action': () => _showComingSoon(context, 'Appointments')},
    {'label': 'Payments', 'icon': Icons.payment, 'action': () => _showComingSoon(context, 'Payments')},
    {'label': 'Settings', 'icon': Icons.settings, 'action': () => _showComingSoon(context, 'Settings')},
  ];

  return Column(
    children: items.map((it) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LargeTile(
        label: it['label'] as String,
        icon: it['icon'] as IconData,
        onTap: it['action'] as void Function(),
      ),
    )).toList(),
  );
}

void _showComingSoon(BuildContext context, String title) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(title), backgroundColor: Brand.primary),
        body: Center(child: Text('$title — coming soon')),
      ),
    ),
  );

}
}
