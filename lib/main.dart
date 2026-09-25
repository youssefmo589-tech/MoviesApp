import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/core/app_routes/app_route_config.dart';
import 'package:movieapp/core/app_routes/app_route_name.dart';
import 'core/app_theme_manager/app_theme_manager.dart';
import 'firebase_options.dart';

import 'modules/layoutviewFeature/datalayer/datasources/history_remote_data_source.dart';
import 'modules/layoutviewFeature/datalayer/repositoryImp/history_repository_impl.dart';
import 'modules/layoutviewFeature/domain/usecases/add_to_history_usecase.dart';
import 'modules/layoutviewFeature/domain/usecases/get_history_usecase.dart';
import 'modules/layoutviewFeature/presentation/manager/history_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final remoteDataSource = HistoryRemoteDataSourceImpl();
        final repository = HistoryRepositoryImpl(remoteDataSource);
        final addToHistoryUseCase = AddToHistoryUseCase(repository);
        final getHistoryUseCase = GetHistoryUseCase(repository);

        return HistoryBloc(
          addToHistoryUseCase: addToHistoryUseCase,
          getHistoryUseCase: getHistoryUseCase,
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouteName.initial,
        onGenerateRoute: AppConfig.onGenerateRoute,
        theme: AppThemeManager.theme,
        builder: BotToastInit(),
      ),
    );
  }
}