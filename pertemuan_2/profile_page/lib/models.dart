class ProfileInfo {
  String name;
  String role;
  String imageUrl;
  String about;
  String education;
  String location;
  String contact;
  List<String> skills;

  ProfileInfo({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.about,
    required this.education,
    required this.location,
    required this.contact,
    required this.skills,
  });

  ProfileInfo copyWith({
    String? name,
    String? role,
    String? imageUrl,
    String? about,
    String? education,
    String? location,
    String? contact,
    List<String>? skills,
  }) {
    return ProfileInfo(
      name: name ?? this.name,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      about: about ?? this.about,
      education: education ?? this.education,
      location: location ?? this.location,
      contact: contact ?? this.contact,
      skills: skills ?? this.skills,
    );
  }
}

class ExperienceInfo {
  String title;
  String description;
  String imageUrl;

  ExperienceInfo({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  ExperienceInfo copyWith({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return ExperienceInfo(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
