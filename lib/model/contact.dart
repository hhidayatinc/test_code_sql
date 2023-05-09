class Contact {
  int? id;
  String? name;
  String? phone;
  String? email;

  Contact({this.id, this.name, this.phone, this.email});

  // Convert Contact object to Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email
    };
    return map;
  }

  // Extract Contact object from Map object
  Contact.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
  }
}
