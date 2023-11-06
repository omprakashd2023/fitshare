import 'dart:convert';
import './challenge_model.dart';

class Community {
  final String id;
  final String name;
  final String description;
  final String location;
  final String admin;
  final List<String> moderators;
  final List<String> members;
  List<Challenge>? challenges;
  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.admin,
    required this.moderators,
    required this.members,
    this.challenges,
  });

  Community copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? admin,
    List<String>? moderators,
    List<String>? members,
    List<Challenge>? challenges,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      admin: admin ?? this.admin,
      moderators: moderators ?? this.moderators,
      members: members ?? this.members,
      challenges: challenges ?? this.challenges,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'admin': admin,
      'moderators': moderators,
      'members': members,
      'challenges': challenges == null
          ? null
          : challenges!.map((x) => x.toMap()).toList(),
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      admin: map['admin'] as String,
      moderators: List<String>.from(
        (map['moderators']),
      ),
      members: List<String>.from(
        (map['members']),
      ),
      challenges: map['challenges'] != null
          ? List<Challenge>.from(
              (map['challenges']).map<Challenge?>(
                (x) => Challenge.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);
}
