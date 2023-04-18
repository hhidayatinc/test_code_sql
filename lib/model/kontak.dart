class Kontak{
  int? id;
  String? nama;
  String? no;
  String? email;
  String? company;

  Kontak({this.id, required this.nama, required this.no, required this.email, required this.company});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

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
    id = map['id'];
    nama = map['nama'];
    no = map['no'];
    email = map['email'];
    company = map['company'];
  }
}

