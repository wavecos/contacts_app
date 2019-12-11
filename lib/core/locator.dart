
import 'package:agenda_app/core/services/contact_service.dart';
import 'package:agenda_app/core/services/contact_service_impl.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ContactService>(() => ContactServiceImpl());
}
