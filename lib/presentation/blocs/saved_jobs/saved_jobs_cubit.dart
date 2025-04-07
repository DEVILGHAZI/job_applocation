import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/job_model.dart';
import '../../../domain/repositories/saved_jobs_repository.dart';
part 'saved_jobs_cubit.freezed.dart'; 


@freezed
class SavedJobsState with _$SavedJobsState {
  const factory SavedJobsState.initial() = _Initial;
  const factory SavedJobsState.loading() = _Loading;
  const factory SavedJobsState.loaded(List<JobModel> savedJobs) = _Loaded;
  const factory SavedJobsState.error(String message) = _Error;
}

class SavedJobsCubit extends Cubit<SavedJobsState> {
  final SavedJobsRepository savedJobsRepository;

  SavedJobsCubit({required this.savedJobsRepository})
      : super(const SavedJobsState.initial());

  Future<void> loadSavedJobs() async {
    emit(const SavedJobsState.loading());
    try {
      final savedJobs = await savedJobsRepository.getSavedJobs();
      emit(SavedJobsState.loaded(savedJobs));
    } catch (e) {
      emit(SavedJobsState.error(e.toString()));
    }
  }

  Future<void> removeFromSaved(JobModel job) async {
    try {
      await savedJobsRepository.unsaveJob(job.id);
      
      // Refresh saved jobs list
      final currentState = state;
      if (currentState is _Loaded) {
        final updatedJobs = currentState.savedJobs
            .where((j) => j.id != job.id)
            .toList();
        
        emit(SavedJobsState.loaded(updatedJobs));
      }
    } catch (e) {
      emit(SavedJobsState.error(e.toString()));
    }
  }
}
