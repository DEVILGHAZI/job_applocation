import '../../data/models/job_model.dart';

abstract class SavedJobsRepository {
  Future<List<JobModel>> getSavedJobs();
  Future<void> saveJob(JobModel job);
  Future<void> unsaveJob(int jobId);
  Future<bool> isJobSaved(int jobId);
}