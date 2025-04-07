import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/job_repository_impl.dart';
import '../../data/repositories/saved_jobs_repository_impl.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/repositories/saved_jobs_repository.dart';
import '../../presentation/blocs/jobs/jobs_cubit.dart';
import '../../presentation/blocs/saved_jobs/saved_jobs_cubit.dart';
import '../../presentation/blocs/theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  
  // Repositories
  sl.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<SavedJobsRepository>(
    () => SavedJobsRepositoryImpl(),
  );
  
  // BLoCs
  sl.registerFactory<JobsCubit>(
    () => JobsCubit(
      jobRepository: sl<JobRepository>(),
      savedJobsRepository: sl<SavedJobsRepository>(),
    ),
  );
  sl.registerFactory<SavedJobsCubit>(
    () => SavedJobsCubit(
      savedJobsRepository: sl<SavedJobsRepository>(),
    ),
  );
  sl.registerFactory<ThemeCubit>(
    () => ThemeCubit(),
  );
}