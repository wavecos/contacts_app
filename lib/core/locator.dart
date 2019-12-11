
import 'package:agenda_app/core/services/contact_service.dart';
import 'package:agenda_app/core/services/contact_service_fb_impl.dart';
import 'package:agenda_app/core/services/contact_service_impl.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

const bool USE_FIREBASE_IMPLEMENTATION = true;

void setupLocator() {
  locator.registerLazySingleton<ContactService>(() => USE_FIREBASE_IMPLEMENTATION ? ContactServiceFbImpl() : ContactServiceImpl());
}
