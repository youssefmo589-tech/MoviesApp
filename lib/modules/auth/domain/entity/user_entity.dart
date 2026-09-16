class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String phone;

  const UserEntity({
    required this.uid,
    required this.email,
    this.name = '',
    this.phone = '',
  });
}