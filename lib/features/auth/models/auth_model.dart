class AppUser {
  final String id;
  final String email;
  final String? name; 
  final String? avatarUrl; 

  AppUser({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'] ?? '',
      name: json['user_metadata']?['full_name'],
      avatarUrl: json['user_metadata']?['avatar_url'],
    );
  }
}