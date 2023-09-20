import 'package:demo_app/api/model/modules.dart';
import 'package:hive/hive.dart';

class ModulesAdapter extends TypeAdapter<Modules> {
  @override
  final int typeId = 9; // Specify the Hive Type ID

  @override
  Modules read(BinaryReader reader) {
    // Read the fields from the binary reader and create a Modules instance
    return Modules(
      moduleVersionId: reader.readInt(),
      version: reader.readInt(),
      description: reader.read(),
      name: reader.readString(),
      slug: reader.readString(),
      startDate: DateTime.parse(
          reader.readString()), // Read as a string and parse to DateTime
      endDate: DateTime.parse(
          reader.readString()), // Read as a string and parse to DateTime
      disableUnits: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Modules obj) {
    // Write the fields of the Modules instance to the binary writer
    writer.writeInt(obj.moduleVersionId ?? 0);
    writer.writeInt(obj.version ?? 0);
    writer.write(obj.description);
    writer.writeString(obj.name ?? '');
    writer.writeString(obj.slug ?? '');
    writer.writeString(obj.startDate!
        .toIso8601String()); // Write as a string in ISO 8601 format
    writer.writeString(
        obj.endDate!.toIso8601String()); // Write as a string in ISO 8601 format
    writer.writeBool(obj.disableUnits ?? false);
  }
}
