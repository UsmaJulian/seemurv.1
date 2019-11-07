class Usuario {
  String uid;
  String foto;
  String nombre;
  String email;
  String password;
  String telefono;

  List calificaciones;
  Usuario(
      {this.uid,
      this.foto,
      this.email,
      this.nombre,
      this.password,
      this.telefono,
      this.calificaciones});
}
