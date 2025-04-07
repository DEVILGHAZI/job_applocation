import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/saved_jobs/saved_jobs_cubit.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({Key? key}) : super(key: key);

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedJobsCubit>().loadSavedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<SavedJobsCubit, SavedJobsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No saved jobs yet')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (savedJobs) {
              if (savedJobs.isEmpty) {
                return const Center(
                  child: Text('No saved jobs yet. Start bookmarking!'),
                );
              }
              
              return ListView.builder(
                itemCount: savedJobs.length,
                itemBuilder: (context, index) {
                  final job = savedJobs[index];
                  return JobCard(
                    job: job,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailScreen(job: job),
                        ),
                      ).then((_) {
                        // Refresh saved jobs when returning from details
                        context.read<SavedJobsCubit>().loadSavedJobs();
                      });
                    },
                    onSaveToggle: () {
                      context.read<SavedJobsCubit>().removeFromSaved(job);
                    },
                  );
                },
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<SavedJobsCubit>().loadSavedJobs(),
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
