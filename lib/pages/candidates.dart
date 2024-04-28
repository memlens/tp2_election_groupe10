import 'dart:io';

class Candidate {
  final String name;
  final String surname;
  final String party;
  final String bio;
  final File? imageUrl;

  Candidate({
    required this.name,
    required this.surname,
    required this.party,
    required this.bio,
    this.imageUrl,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      party: json['party'] ?? '',
      bio: json['bio'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'party': party,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }
}
