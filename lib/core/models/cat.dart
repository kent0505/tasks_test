import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class Cat {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  Cat({
    required this.id,
    required this.title,
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
    );
  }

  @override
  void write(BinaryWriter writer, Cat obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
  }
}

List<Cat> defaultCategories = [
  Cat(id: 1, title: 'Work'),
  Cat(id: 13, title: 'Sport'),
  Cat(id: 14, title: 'Shopping'),
  Cat(id: 15, title: 'Education'),
];
