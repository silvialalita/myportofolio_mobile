import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.projectImageUrl.isNotEmpty) ...[
              Image.network(
                project.projectImageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Unable to load project image.');
                },
              ),
              const SizedBox(height: 16),
            ],
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text('Description: ${project.description}'),
            const SizedBox(height: 8),
            Text('Tech Stack: ${project.techStack}'),
            const SizedBox(height: 8),
            Text('Project URL: ${project.projectUrl}'),
          ],
        ),
      ),
    );
  }
}
