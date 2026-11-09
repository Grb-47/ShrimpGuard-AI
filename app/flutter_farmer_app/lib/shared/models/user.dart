class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.role = 'farmer',
  });

  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String role;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      role: json['role'] as String? ?? 'farmer',
    );
  }
}
