class ProfileModel {
  String name;
  String age;

  ProfileModel({required this.name, required this.age});

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      name: jsonData['name'] ?? '',
      age: jsonData['age'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}
