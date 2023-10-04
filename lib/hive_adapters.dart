import 'package:hive/hive.dart';

import 'api/model/clinical_skills.dart';
import 'api/model/clinical_skills_adapter.dart';
import 'api/model/instructors.dart';
import 'api/model/instructors_adapter.dart';
import 'api/model/modules.dart';
import 'api/model/modules_adapter.dart';
import 'api/model/user_model.dart';
import 'api/model/user_model_adapter.dart';

Future<void> registerHiveAdapters() async {
  Hive.registerAdapter(InstructorsAdapter());
  Hive.registerAdapter(ClinicalSkillsAdapter());
  Hive.registerAdapter(AssessmentAdapter());
  Hive.registerAdapter(InstructorCRAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AvatarsAdapter());
  Hive.registerAdapter(ClinicalRotationAdapter());
  Hive.registerAdapter(LinksAdapter());
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(ModulesAdapter());

  await Hive.openBox<Instructors>('instructorsBox');
  await Hive.openBox<ClinicalSkills>('clinicalSkillsBox');
  await Hive.openBox<User>('userBox');
  await Hive.openBox<Modules>('modulesBox');
  await Hive.openBox('skillDataBox');
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<Instructors>('instructorsBox');
  await Hive.openBox<ClinicalSkills>('clinicalSkillsBox');
  await Hive.openBox<User>('userBox');
  await Hive.openBox<Modules>('modulesBox');
  await Hive.openBox('skillDataBox');
}

Future<void> clearBoxes() async {
  await Hive.box('instructorsBox').clear();
  await Hive.box('clinicalSkillsBox').clear();
  await Hive.box('userBox').clear();
  await Hive.box('modulesBox').clear();
  await Hive.box('skillDataBox').clear();

  await Hive.close();
}
