class User {
  final int id;
  final String name;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.password,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, name: $name, password: $password}';
  }
}
