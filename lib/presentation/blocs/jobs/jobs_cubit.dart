import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/job_model.dart';
import '../../../domain/repositories/job_repository.dart';
import '../../../domain/repositories/saved_jobs_repository.dart';
part 'jobs_cubit.freezed.dart'; 


@freezed
class JobsState with _$JobsState {
  const factory JobsState.initial() = _Initial;
  const factory JobsState.loading() = _Loading;
  const factory JobsState.loaded(List<JobModel> jobs) = _Loaded;
  const factory JobsState.error(String message) = _Error;
}

class JobsCubit extends Cubit<JobsState> {
  final JobRepository jobRepository;
  final SavedJobsRepository savedJobsRepository;

  JobsCubit({
    required this.jobRepository,
    required this.savedJobsRepository,
  }) : super(const JobsState.initial());

  Future<void> loadJobs() async {
    emit(const JobsState.loading());
    try {
      final jobs = await jobRepository.getJobs();
      
      // Check which jobs are saved
      final List<JobModel> updatedJobs = [];
      for (var job in jobs) {
        final isSaved = await savedJobsRepository.isJobSaved(job.id);
        updatedJobs.add(job.copyWith(isSaved: isSaved));
      }
      
      emit(JobsState.loaded(updatedJobs));
    } catch (e) {
      emit(JobsState.error(e.toString()));
    }
  }

  Future<void> toggleSaveJob(JobModel job) async {
    try {
      if (job.isSaved) {
        await savedJobsRepository.unsaveJob(job.id);
      } else {
        await savedJobsRepository.saveJob(job);
      }
      
      // Refresh jobs list
      final currentState = state;
      if (currentState is _Loaded) {
        final updatedJobs = currentState.jobs.map((j) {
          if (j.id == job.id) {
            return j.copyWith(isSaved: !j.isSaved);
          }
          return j;
        }).toList();
        
        emit(JobsState.loaded(updatedJobs));
      }
    } catch (e) {
      emit(JobsState.error(e.toString()));
    }
  }
}
