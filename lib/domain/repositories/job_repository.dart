import '../../data/models/job_model.dart';

abstract class JobRepository {
  Future<List<JobModel>> getJobs();
}
