import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class Cat {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int iconId;

  Cat({
    required this.id,
    required this.title,
    required this.iconId,
  });
}

class CatAdapter extends TypeAdapter<Cat> {
  @override
  final typeId = 2;

  @override
  Cat read(BinaryReader reader) {
    return Cat(
      id: reader.readInt(),
      title: reader.readString(),
      iconId: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Cat obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeInt(obj.iconId);
  }
}

List<Cat> defaultCategories = [
  Cat(id: 1, title: 'Work', iconId: 1),
  Cat(id: 2, title: 'Sport', iconId: 13),
  Cat(id: 3, title: 'Shopping', iconId: 14),
  Cat(id: 4, title: 'Education', iconId: 15),
];
