class StudentClassDTO {
  String? id; // class local id
  String acronym; // ECOI20
  String place; // sala 3 - anexo a
  String classname; // Gestão de projetos

  StudentClassDTO(
      {required this.acronym, required this.place, required this.classname});

  Map<String, dynamic> toMap() => {
        'id': id,
        'acronym': acronym,
        'place': place,
        'classname': classname,
      };
}
