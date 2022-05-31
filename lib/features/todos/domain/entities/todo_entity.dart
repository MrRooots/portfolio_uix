import 'package:equatable/equatable.dart';

import '../../../../core/data/todos/data.dart';

class TodoEntity extends Equatable {
  /// [TodoEntity] title
  final String title;

  /// [TodoEntity] type: { 0 - bad, 1 - good }
  final TodoType type;

  /// [TodoEntity] priority: { 0 - low, 1 - medium, 2 - high }
  final TodoPriority priority;

  /// [TodoEntity] creation date timestamp
  final DateTime createdAt;

  /// [TodoEntity] complete marker
  final bool isCompleted;

  /// Constructor
  const TodoEntity({
    required final this.title,
    required final this.type,
    required final this.priority,
    required final this.createdAt,
    required final this.isCompleted,
  });

  @override
  List<Object?> get props => [
        title,
        type,
        priority,
        createdAt,
        isCompleted,
      ];
}
