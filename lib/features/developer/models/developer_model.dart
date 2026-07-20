class DeveloperModel {
  final String name;
  final String designation;
  final String bio;
  final String photo;

  final String email;
  final String phone;
  final String location;

  final String instagram;
  final String facebook;
  final String linkedin;
  final String github;
  final String portfolio;

  final String version;

  const DeveloperModel({
    required this.name,
    required this.designation,
    required this.bio,
    required this.photo,
    required this.email,
    required this.phone,
    required this.location,
    required this.instagram,
    required this.facebook,
    required this.linkedin,
    required this.github,
    required this.portfolio,
    required this.version,
  });

  factory DeveloperModel.fromMap(Map<String, dynamic> map) {
    return DeveloperModel(
      name: map["name"] ?? "",
      designation: map["designation"] ?? "",
      bio: map["bio"] ?? "",
      photo: map["photo"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      location: map["location"] ?? "",
      instagram: map["instagram"] ?? "",
      facebook: map["facebook"] ?? "",
      linkedin: map["linkedin"] ?? "",
      github: map["github"] ?? "",
      portfolio: map["portfolio"] ?? "",
      version: map["version"] ?? "1.0.0",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "designation": designation,
      "bio": bio,
      "photo": photo,
      "email": email,
      "phone": phone,
      "location": location,
      "instagram": instagram,
      "facebook": facebook,
      "linkedin": linkedin,
      "github": github,
      "portfolio": portfolio,
      "version": version,
    };
  }
}