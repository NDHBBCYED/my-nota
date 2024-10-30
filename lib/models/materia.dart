
class Materia {
  
  final int id;
  final String materia;
  final String docente;
  final String creditos;
  final String nota1;
  final String nota2;
  final String nota3;
  
  Materia({
    this.id,
    this.materia,
    this.docente,
    this.creditos,
    this.nota1,
    this.nota2,
    this.nota3,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'materia': materia,
      'docente': docente,
      'creditos': creditos,
      'nota1': nota1,
      'nota2': nota2,
      'nota3': nota3
    };
  }

  factory Materia.fromMap(Map<String, dynamic> json) => new Materia(id: json['id'], materia: json['materia'], docente: json['docente'], creditos: json['creditos']);

}
