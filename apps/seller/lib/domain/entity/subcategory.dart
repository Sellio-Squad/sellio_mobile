import 'package:equatable/equatable.dart';

class Subcategory extends Equatable {
  final String id;
  final String name;

  const Subcategory({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
