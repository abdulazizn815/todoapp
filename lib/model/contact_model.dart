class Contact {
  String name;
  String phoneNumber;
  String id;
  String address;
  String company;
  bool isFavorited;
  Contact({
    required this.name,
    required this.id,
    required this.phoneNumber,
    required this.address,
    required this.company,
    required this.isFavorited,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'phoneNumber': phoneNumber,
        'address': address,
        'company': company,
        'isFavorited': isFavorited
      };
}
