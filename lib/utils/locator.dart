import 'package:get_it/get_it.dart';
import 'package:meme_generator/bloc/json_bloc/json_bloc.dart';
import 'package:meme_generator/utils/widget_manager.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<JsonBloc>(() => JsonBloc());
}
