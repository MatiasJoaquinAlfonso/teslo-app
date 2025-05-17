class User {
  final String id;
  final String email;
  final String fullnName;
  final List<String> roles;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.fullnName,
    required this.roles,
    required this.token
  });

  bool get isAdmin {
    return roles.contains('admin');
  }
}
