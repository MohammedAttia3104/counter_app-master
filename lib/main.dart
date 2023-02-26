import 'package:counter_app/business_logic/counter_app_bloc.dart';
import 'package:counter_app/data/cache_helper/cache_helper.dart';
import 'package:counter_app/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_observer.dart' as bo;
import 'data/repository/repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Bloc.observer = const bo.AppBlocObserver();
  initDI(sharedPreferences);
  runApp(const MyApp());
}

final GetIt _sl = GetIt.instance;

void initDI(SharedPreferences sharedPreferences) {
  _sl.registerSingleton(DataSource(_sl.get<SharedPreferences>()));
  _sl.registerSingleton(Repository(_sl.get<DataSource>()));
  _sl.registerFactory(() => CounterAppBloc(_sl.get<Repository>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _sl.get<CounterAppBloc>(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
