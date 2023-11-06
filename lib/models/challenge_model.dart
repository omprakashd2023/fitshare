import 'dart:convert';

class Challenge {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String communityId;
  final String creatorId;
  final List<String> winners;
  final List<String> participants;
  final String amount;
  final String status;
  Challenge({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.communityId,
    required this.creatorId,
    required this.winners,
    required this.participants,
    required this.amount,
    required this.status,
  });

  Challenge copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? communityId,
    String? creatorId,
    List<String>? winners,
    List<String>? participants,
    String? amount,
    String? status,
  }) {
    return Challenge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      communityId: communityId ?? this.communityId,
      creatorId: creatorId ?? this.creatorId,
      winners: winners ?? this.winners,
      participants: participants ?? this.participants,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'communityId': communityId,
      'creatorId': creatorId,
      'winners': winners,
      'participants': participants,
      'amount': amount,
      'status': status,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      communityId: map['communityId'] as String,
      creatorId: map['creatorId'] as String,
      winners: List<String>.from(
        (map['winners']),
      ),
      participants: List<String>.from(
        (map['participants']),
      ),
      amount: map['amount'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source));
}
