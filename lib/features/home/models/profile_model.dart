class Profile {
  final int id;
  final String name;
  final String email;

  Profile({
    required this.id, required this.name, required this.email
  });

  // CopyWith method
  Profile copyWith({
    int? id, String? name, String? email
  }) {
    return Profile(
      id: id ?? this.id, name: name ?? this.name, email: email ?? this.email
    );
  }

  // JSON serialization methods
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email
    };
  }

  // toString method
  @override
  String toString() {
    return 'Profile(id: $id, name: $name, email: $email)';
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
      id == other.id && name == other.name && email == other.email;
  }

  // hashCode method
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
