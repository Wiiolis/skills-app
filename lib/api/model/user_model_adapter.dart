import 'package:hive/hive.dart';
import 'user_model.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final fields = reader.readMap();
    return User()
      ..avatars = fields[0] as Avatars?
      ..bio = fields[1] as String?
      ..birthDate = fields[2]
      ..cityOfResidence = fields[3] as String?
      ..clinicalRotation = fields[4] as ClinicalRotation?
      ..countryId = fields[5] as String?
      ..createdAt =
          fields[6] == null ? null : DateTime.parse(fields[6] as String)
      ..firstName = fields[7] as String?
      ..jobTitle = fields[8] as String?
      ..lastName = fields[9] as String?
      ..links = fields[10] as Links?
      ..personalQuote = fields[11] as String?
      ..ppAcceptedAt =
          fields[12] == null ? null : DateTime.parse(fields[12] as String)
      ..role = fields[13] as Role?
      ..slug = fields[14] as String?
      ..studentId = fields[15]
      ..systemLanguage = fields[16] as String?
      ..teachingStaff = fields[17] as bool?
      ..teams = fields[18] as List<dynamic>?
      ..tosAcceptedAt =
          fields[19] == null ? null : DateTime.parse(fields[19] as String)
      ..userId = fields[20] as int?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeMap({
      0: obj.avatars,
      1: obj.bio,
      2: obj.birthDate,
      3: obj.cityOfResidence,
      4: obj.clinicalRotation,
      5: obj.countryId,
      6: obj.createdAt?.toIso8601String(),
      7: obj.firstName,
      8: obj.jobTitle,
      9: obj.lastName,
      10: obj.links,
      11: obj.personalQuote,
      12: obj.ppAcceptedAt?.toIso8601String(),
      13: obj.role,
      14: obj.slug,
      15: obj.studentId,
      16: obj.systemLanguage,
      17: obj.teachingStaff,
      18: obj.teams,
      19: obj.tosAcceptedAt?.toIso8601String(),
      20: obj.userId,
    });
  }
}

class AvatarsAdapter extends TypeAdapter<Avatars> {
  @override
  final int typeId = 5;

  @override
  Avatars read(BinaryReader reader) {
    final fields = reader.readMap();
    return Avatars()
      ..normal = fields[0] as String?
      ..small = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, Avatars obj) {
    writer.writeMap({
      0: obj.normal,
      1: obj.small,
    });
  }
}

class ClinicalRotationAdapter extends TypeAdapter<ClinicalRotation> {
  @override
  final int typeId = 6;

  @override
  ClinicalRotation read(BinaryReader reader) {
    final fields = reader.readMap();
    return ClinicalRotation()
      ..groupName = fields[0] as String?
      ..hospitalId = fields[1] as int?
      ..hospitalName = fields[2] as String?
      ..userGroupId = fields[3] as int?
      ..hospitalEmail = fields[4] as String?
      ..hospitalContact = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, ClinicalRotation obj) {
    writer.writeMap({
      0: obj.groupName,
      1: obj.hospitalId,
      2: obj.hospitalName,
      3: obj.userGroupId,
      4: obj.hospitalEmail,
      5: obj.hospitalContact,
    });
  }
}

class LinksAdapter extends TypeAdapter<Links> {
  @override
  final int typeId = 7;

  @override
  Links read(BinaryReader reader) {
    final fields = reader.readMap();
    return Links()..instagramUrl = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Links obj) {
    writer.writeMap({
      0: obj.instagramUrl,
    });
  }
}

class RoleAdapter extends TypeAdapter<Role> {
  @override
  final int typeId = 8;

  @override
  Role read(BinaryReader reader) {
    final fields = reader.readMap();
    return Role()
      ..code = fields[0] as String?
      ..color = fields[1] as String?
      ..label = fields[2] as String?
      ..primary = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, Role obj) {
    writer.writeMap({
      0: obj.code,
      1: obj.color,
      2: obj.label,
      3: obj.primary,
    });
  }
}
