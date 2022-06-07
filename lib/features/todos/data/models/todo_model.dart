import '../../../../core/data/todos/data.dart';
import '../../domain/entities/todo_entity.dart';

class TodoModelMapper {
  /// Map given [value] to [TodoType]
  static TodoType typeFromInt(final int value) =>
      TodoType.values.elementAt(value);

  /// Map given [value] to [TodoPriority]
  static TodoPriority priorityFromInt(final int value) =>
      TodoPriority.values.elementAt(value);

  /// Map given [value] to index of [TodoType] or [TodoPriority] enums
  static int valueToInt(final value) => value is TodoType
      ? TodoType.values.indexOf(value)
      : TodoPriority.values.indexOf(value);
}

class TodoModel extends TodoEntity {
  /// Constructor
  const TodoModel({
    required final int? id,
    required final String uuid,
    required String title,
    required TodoType type,
    required TodoPriority priority,
    required DateTime createdAt,
    required bool isCompleted,
  }) : super(
          id: id,
          uuid: uuid,
          title: title,
          type: type,
          priority: priority,
          createdAt: createdAt,
          isCompleted: isCompleted,
        );

  /// Create [TodoModel] from given [json] like object
  factory TodoModel.fromJson({required final Map<String, dynamic> json}) =>
      TodoModel(
        id: json['id'],
        uuid: json['uuid'],
        title: json['title'],
        type: TodoModelMapper.typeFromInt(json['type']),
        priority: TodoModelMapper.priorityFromInt(json['priority']),
        createdAt: DateTime.parse(json['createdAt']),
        isCompleted: json['isCompleted'],
      );

  /// Map current [TodoModel] into json object
  Map<String, dynamic> toJson() => {
        'title': title,
        'type': TodoModelMapper.valueToInt(type),
        'priority': TodoModelMapper.valueToInt(priority),
        'createdAt': createdAt.toIso8601String(),
        'isCompleted': isCompleted,
      };

  /// Copy current [TodoModel] with given values
  TodoModel copyWith({
    final int? id,
    final String? uuid,
    final String? title,
    final TodoType? type,
    final TodoPriority? priority,
    final DateTime? createdAt,
    final bool? isCompleted,
  }) =>
      TodoModel(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        type: type ?? this.type,
        priority: priority ?? this.priority,
        createdAt: createdAt ?? this.createdAt,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  /// Mark current [TodoModel] as (un)completed and return modified [TodoModel]
  TodoModel get markCompleted {
    return isCompleted
        ? copyWith(isCompleted: false)
        : copyWith(isCompleted: true);
  }
}
