import 'package:hive/hive.dart';
import 'clinical_skills.dart'; // Import your existing model classes

class ClinicalSkillsAdapter extends TypeAdapter<ClinicalSkills> {
  @override
  final int typeId = 1; // Assign a unique typeId for the class

  @override
  ClinicalSkills read(BinaryReader reader) {
    return ClinicalSkills(
      name: reader.read() as String?, // Handle nullability
      level: reader.read() as String?,
      module: reader.read() as String?,
      assessment: reader.read() as Assessment?,
      clinicalSkillId: reader.read() as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ClinicalSkills obj) {
    writer.write(obj.name);
    writer.write(obj.level);
    writer.write(obj.module);
    writer.write(obj.assessment);
    writer.write(obj.clinicalSkillId);
  }
}

class AssessmentAdapter extends TypeAdapter<Assessment> {
  @override
  final int typeId = 2;

  @override
  Assessment read(BinaryReader reader) {
    return Assessment(
      level: reader.read() as String?,
      instructor: reader.read() as InstructorCR?,
      assessmentDate: DateTime.tryParse(reader.read() as String? ?? ''),
      moduleVersionId: reader.read() as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Assessment obj) {
    writer.write(obj.level);
    writer.write(obj.instructor);
    writer.write(
        obj.assessmentDate?.toIso8601String() ?? ''); // Handle nullability
    writer.write(obj.moduleVersionId);
  }
}

class InstructorCRAdapter extends TypeAdapter<InstructorCR> {
  @override
  final int typeId = 3;

  @override
  InstructorCR read(BinaryReader reader) {
    return InstructorCR(
      fullName: reader.read() as String?,
      department: reader.read() as String?,
      hospitalId: reader.read() as int?,
      instructorId: reader.read() as int?,
    );
  }

  @override
  void write(BinaryWriter writer, InstructorCR obj) {
    writer.write(obj.fullName);
    writer.write(obj.department);
    writer.write(obj.hospitalId);
    writer.write(obj.instructorId);
  }
}
