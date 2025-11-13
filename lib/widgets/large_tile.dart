import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LargeTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const LargeTile({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
          ),
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Brand.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Brand.primary, size: 26),
              ),
              SizedBox(width: 14),
              Expanded(child: Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
              Icon(Icons.chevron_right, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}