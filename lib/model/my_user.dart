class MyUser {
  static const String collectionName = 'Users';
  String id;
  String name;
  String email;
  int imageIndex;
  String phoneNumber;

  MyUser({
    required this.name,
    required this.email,
    required this.id,
    required this.imageIndex,
    required this.phoneNumber,
  });

  MyUser.fromJson(Map<String, dynamic> data)
    : this(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        imageIndex: data['image_index'],
        phoneNumber: data['phone_number'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image_index': imageIndex,
      'phone_number': phoneNumber,
    };
  }
}
