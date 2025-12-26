import 'package:equatable/equatable.dart';

class SilenceContext extends Equatable {
  final int code;
  final String label;

  const SilenceContext({required this.code, required this.label});

  @override
  List<Object?> get props => [code, label];
}
