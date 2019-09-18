class Usuario {
  Usuario(
      {this.uid,
      this.foto,
      this.email,
      this.nombre,
      this.password,
      this.telefono,
      this.calificaciones});

  String uid;
  String foto;
  String nombre;
  String email;
  String password;
  String telefono;
  //String direccion;
  // String ciudad;
  List calificaciones;
}
