class Kontak{
  int? id;
  String? nama;
  String? no;
  String? email;
  String? company;

  Kontak({this.id, required this.nama, required this.no, required this.email, required this.company});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['no'] = no;
    map['email'] = email;
    map['company'] = company;

    return map;
  }

  Kontak.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.no = map['no'];
    this.email = map['email'];
    this.company = map['company'];
  }
}

