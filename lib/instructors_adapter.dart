import 'package:hive/hive.dart';

import 'api/model/instructors.dart';

class InstructorsAdapter extends TypeAdapter<Instructors> {
  @override
  final int typeId =
      0; // This should match the typeId you defined in the Instructors class

  @override
  Instructors read(BinaryReader reader) {
    return Instructors(
      name: reader.read(),
      instructorId: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Instructors obj) {
    writer.write(obj.name);
    writer.write(obj.instructorId);
  }
}
