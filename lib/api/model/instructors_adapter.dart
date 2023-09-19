import 'package:hive/hive.dart';
import 'instructors.dart';

class InstructorsAdapter extends TypeAdapter<Instructors> {
  @override
  final typeId = 0; // Unique type ID for your class

  @override
  Instructors read(BinaryReader reader) {
    return Instructors(
      name: reader.readString(),
      instructorId: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Instructors obj) {
    writer.writeString(obj.name ?? '');
    writer.writeInt(obj.instructorId ?? 0);
  }
}
