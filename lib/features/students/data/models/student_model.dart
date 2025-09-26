import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String name;
  final String? phone;
  final int? age;
  final String beltLevel; // Default 'White'
  final String subscriptionStatus; // Default 'pending'
  final DateTime createdAt;

  const Student({
    required this.id,
    required this.name,
    this.phone,
    this.age,
    this.beltLevel = 'White',
    this.subscriptionStatus = 'pending',
    required this.createdAt,
  });

  // From JSON (e.g., from Supabase)
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      age: json['age'] as int?,
      beltLevel: json['belt_level'] as String? ?? 'White',
      subscriptionStatus: json['subscription_status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // To JSON (for inserting/updating)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'age': age,
      'belt_level': beltLevel,
      'subscription_status': subscriptionStatus,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // CopyWith for immutability
  Student copyWith({
    String? id,
    String? name,
    String? phone,
    int? age,
    String? beltLevel,
    String? subscriptionStatus,
    DateTime? createdAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      beltLevel: beltLevel ?? this.beltLevel,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    age,
    beltLevel,
    subscriptionStatus,
    createdAt,
  ];
}
