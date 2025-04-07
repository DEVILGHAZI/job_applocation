import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/jobs/jobs_cubit.dart';
import '../blocs/theme/theme_cubit.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';
import 'saved_jobs_screen.dart';

class JobListingScreen extends StatefulWidget {
  const JobListingScreen({Key? key}) : super(key: key);

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<JobsCubit>().loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SavedJobsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Load jobs to start')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (jobs) {
              return RefreshIndicator(
                onRefresh: () => context.read<JobsCubit>().loadJobs(),
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return JobCard(
                      job: job,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => JobDetailScreen(job: job),
                          ),
                        ).then((_) {
                          context.read<JobsCubit>().loadJobs();
                        });
                      },
                      onSaveToggle: () {
                        context.read<JobsCubit>().toggleSaveJob(job);
                      },
                    );
                  },
                ),
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<JobsCubit>().loadJobs(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}