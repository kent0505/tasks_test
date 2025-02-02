import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List subtasks;

  @HiveField(3)
  int categoryId;

  @HiveField(4)
  String date;

  @HiveField(5)
  String startTime;

  @HiveField(6)
  String endTime;

  @HiveField(7)
  bool remind;

  @HiveField(8)
  bool done;

  Task({
    required this.id,
    required this.title,
    required this.subtasks,
    required this.categoryId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.done,
  });
}

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 0;

  @override
  Task read(BinaryReader reader) {
    return Task(
      id: reader.readInt(),
      title: reader.readString(),
      subtasks: reader.read(),
      categoryId: reader.readInt(),
      date: reader.readString(),
      startTime: reader.readString(),
      endTime: reader.readString(),
      remind: reader.readBool(),
      done: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.write(obj.subtasks);
    writer.writeInt(obj.categoryId);
    writer.writeString(obj.date);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
    writer.writeBool(obj.remind);
    writer.writeBool(obj.done);
  }
}
