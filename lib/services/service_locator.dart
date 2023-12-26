import 'package:audio_service/audio_service.dart';
import 'package:reka/services/api_service.dart';

import '../page_manager.dart';
import 'audio_handler.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<ApiService>(() => TestApiService());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
