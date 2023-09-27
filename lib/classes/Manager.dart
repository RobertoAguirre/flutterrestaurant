class Manager {
  final String id;
  //final String name;
  final String email;
  final String role;

  Manager({
    required this.id,
    //required this.name,
    required this.email,
    required this.role,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['_id'],
      //name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  get name => null;
}