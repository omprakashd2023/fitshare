import 'dart:convert';

class Workout {
  final String name;
  final String startTime;
  final String repetitions;
  final String difficulty;
  final String userId;
  final bool isCompleted = false;
  Workout({
    required this.name,
    required this.startTime,
    required this.repetitions,
    required this.difficulty,
    required this.userId,
  });

  Workout copyWith({
    String? name,
    String? startTime,
    String? repetitions,
    String? difficulty,
    String? userId,
  }) {
    return Workout(
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      repetitions: repetitions ?? this.repetitions,
      difficulty: difficulty ?? this.difficulty,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'startTime': startTime,
      'repetitions': repetitions,
      'difficulty': difficulty,
      'userId': userId,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] as String,
      startTime: map['startTime'] as String,
      repetitions: map['repetitions'] as String,
      difficulty: map['difficulty'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Workout(name: $name, startTime: $startTime, repetitions: $repetitions, difficulty: $difficulty, userId: $userId)';
  }

  @override
  bool operator ==(covariant Workout other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.startTime == startTime &&
        other.repetitions == repetitions &&
        other.difficulty == difficulty &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        startTime.hashCode ^
        repetitions.hashCode ^
        difficulty.hashCode ^
        userId.hashCode;
  }
}
