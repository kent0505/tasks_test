import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int iconId;

  Category({
    required this.id,
    required this.title,
    required this.iconId,
  });
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final typeId = 2;

  @override
  Category read(BinaryReader reader) {
    return Category(
      id: reader.readInt(),
      title: reader.readString(),
      iconId: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeInt(obj.iconId);
  }
}

List<Category> defaultCategories = [
  Category(id: 1, title: 'Work', iconId: 1),
  Category(id: 2, title: 'Sport', iconId: 13),
  Category(id: 3, title: 'Shopping', iconId: 14),
  Category(id: 4, title: 'Education', iconId: 15),
];
