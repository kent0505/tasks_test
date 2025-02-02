import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Subtask {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool done;

  Subtask({
    required this.id,
    required this.title,
    required this.done,
  });

  Subtask.from(Subtask subtask)
      : id = subtask.id,
        done = subtask.done,
        title = subtask.title;
}

class SubtaskAdapter extends TypeAdapter<Subtask> {
  @override
  final typeId = 1;

  @override
  Subtask read(BinaryReader reader) {
    return Subtask(
      id: reader.readInt(),
      title: reader.readString(),
      done: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Subtask obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeBool(obj.done);
  }
}
