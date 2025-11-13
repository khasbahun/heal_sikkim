class Patient {
  final String name;
  final String phone;
  final String address;
  final int age;
  final String gender;
  final String appointment;

  Patient({required this.name, required this.phone, required this.address, required this.age, required this.gender, required this.appointment});

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'address': address,
    'age': age,
    'gender': gender,
    'appointment': appointment,
  };
}