import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/job_model.dart';
import '../blocs/jobs/jobs_cubit.dart';

class JobDetailScreen extends StatelessWidget {
  final JobModel job;
  
  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'), 
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Icon(
              job.isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: job.isSaved ? Colors.amber : null,
            ),
            onPressed: () {
              context.read<JobsCubit>().toggleSaveJob(job);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (job.logoUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    job.logoUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              job.title,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.business, size: 18, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  job.company,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 18, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  job.location,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.attach_money, size: 18, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  job.salary,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  'Posted on: ${job.postedDate}',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Description',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(job.description),
            const SizedBox(height: 24),
            Text(
              'Requirements',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(job.requirements),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application submitted successfully!'),
                    ),
                  );
                },
                child: const Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}