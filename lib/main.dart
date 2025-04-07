import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_applocation/presentation/screens/splash_screen.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/blocs/jobs/jobs_cubit.dart';
import 'presentation/blocs/saved_jobs/saved_jobs_cubit.dart';
import 'presentation/blocs/theme/theme_cubit.dart';
import 'presentation/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>(),
        ),
        BlocProvider<JobsCubit>(
          create: (_) => di.sl<JobsCubit>(),
        ),
        BlocProvider<SavedJobsCubit>(
          create: (_) => di.sl<SavedJobsCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Job Listing App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
