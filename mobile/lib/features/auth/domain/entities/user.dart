import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final String email;
  final String timezone;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.timezone,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    fullname,
    email,
    timezone,
    createdAt,
    updatedAt,
  ];
}
