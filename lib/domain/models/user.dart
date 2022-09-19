import '../../data/database/database_constants.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.image,
  });

  User.empty({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.image = '',
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? image,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap({bool isLoggedIn = false}) {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      DatabaseConstants.tableUsersColEmail: email,
      DatabaseConstants.tableUsersColPassword: password,
      DatabaseConstants.tableUsersColLoggedIn: isLoggedIn,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, phone: $phone, email: $email, password: $password}';
  }
}
