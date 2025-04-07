import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/repositories/saved_jobs_repository.dart';
import '../models/job_model.dart';

class SavedJobsRepositoryImpl implements SavedJobsRepository {
  final String _key = 'saved_jobs';

  @override
  Future<List<JobModel>> getSavedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedJobsJson = prefs.getStringList(_key) ?? [];
    
    return savedJobsJson
        .map((jobJson) => JobModel.fromJson(json.decode(jobJson)))
        .toList();
  }

  @override
  Future<void> saveJob(JobModel job) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJobsJson = prefs.getStringList(_key) ?? [];
    final jobExists = savedJobsJson.any((jobJson) {
      final existingJob = JobModel.fromJson(json.decode(jobJson));
      return existingJob.id == job.id;
    });
    
    if (!jobExists) {
      savedJobsJson.add(json.encode(job.copyWith(isSaved: true).toJson()));
      await prefs.setStringList(_key, savedJobsJson);
    }
  }

  @override
  Future<void> unsaveJob(int jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJobsJson = prefs.getStringList(_key) ?? [];
    
    final updatedJobs = savedJobsJson.where((jobJson) {
      final job = JobModel.fromJson(json.decode(jobJson));
      return job.id != jobId;
    }).toList();
    
    await prefs.setStringList(_key, updatedJobs);
  }

  @override
  Future<bool> isJobSaved(int jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedJobsJson = prefs.getStringList(_key) ?? [];
    
    return savedJobsJson.any((jobJson) {
      final job = JobModel.fromJson(json.decode(jobJson));
      return job.id == jobId;
    });
  }
}
