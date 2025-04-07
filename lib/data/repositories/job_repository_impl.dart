import 'package:dio/dio.dart';
import '../../domain/repositories/job_repository.dart';
import '../models/job_model.dart';

class JobRepositoryImpl implements JobRepository {
  final Dio dio;

  JobRepositoryImpl(this.dio);

  @override
  Future<List<JobModel>> getJobs() async {
    try {
      // Since reqres.in doesn't have job data, we'll adapt its user endpoint
      final response = await dio.get('https://reqres.in/api/users?page=1');
      
      if (response.statusCode == 200) {
        // Transform the data to match our JobModel format it's just a mock
        final List<dynamic> users = response.data['data'];
        return users.map((user) => JobModel(
          id: user['id'],
          title: 'Flutter Developer ${user['id']}',
          company: '${user['first_name']} ${user['last_name']} Corp',
          location: 'Remote',
          description: 'We are looking for a Flutter developer to join our team. Your primary focus will be developing mobile applications using Flutter and Dart.',
          requirements: 'Strong knowledge of Flutter, Dart, and mobile app development. Experience with state management solutions like BLoC.',
          salary: '₹15,000 - ₹25,000',
          postedDate: '${DateTime.now().day - (user['id'] % 30)}-${DateTime.now().month}-${DateTime.now().year}',
          logoUrl: user['avatar'],
        )).toList();
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Error fetching jobs: $e');
    }
  }
}
