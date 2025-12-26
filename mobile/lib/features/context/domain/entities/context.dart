import 'package:equatable/equatable.dart';

/// Domain entity for context
class Context extends Equatable {
  final int code;
  final String label;
  final String module;

  const Context({
    required this.code,
    required this.label,
    required this.module,
  });

  @override
  List<Object?> get props => [code, label, module];
}
