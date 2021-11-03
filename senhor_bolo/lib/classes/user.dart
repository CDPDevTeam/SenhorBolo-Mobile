class User{
  final String _email;
  final String _username;
  final String _cpf;
  final String _image;

  User(this._email, this._username, this._cpf, this._image);

  String get username => _username;
  String get cpf => _cpf;
  String get image => _image;
}