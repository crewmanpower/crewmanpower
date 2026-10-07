import 'package:crewmanpower/core/model/job_model.dart';
import 'package:crewmanpower/features/landing/section/career_intake_form.dart';
import 'package:flutter/material.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';

class CareerView extends StatefulWidget {
  const CareerView({super.key});

  @override
  State<CareerView> createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {
  JobModel? _selectedJob;
  final JobService _jobService = JobService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;

    Widget dynamicBodyContent;

    if (_selectedJob == null) {
      int crossAxisCount = width > 1200 ? 3 : (width > 750 ? 2 : 1);
      double aspectRatio = width > 1200 ? 1.35 : (width > 750 ? 1.25 : 1.4);

      dynamicBodyContent = SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: isDesktop ? 60 : 20,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Explore Career Trajectories",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Select an active deployment listing below to engage the application intake system pipeline.",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                const SizedBox(height: 35),
                
                // Real-time StreamBuilder fetching jobs from Firebase 'open_jobs' collection
                StreamBuilder<List<JobModel>>(
                  stream: _jobService.getOpenJobsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final jobsList = snapshot.data ?? [];

                    if (jobsList.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                            "No active job openings available at the moment. Please check back later.",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: jobsList.length,
                      itemBuilder: (context, index) {
                        return _buildJobCard(jobsList[index]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      dynamicBodyContent = SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: isDesktop ? 60 : 20,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => setState(() => _selectedJob = null),
                  icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0D47A1)),
                  label: const Text(
                    "Return to Listings",
                    style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: _buildJobDetailsPane(_selectedJob!)),
                          const SizedBox(width: 45),
                          Expanded(flex: 5, child: CareerIntakeForm(selectedJob: _selectedJob!)),
                        ],
                      )
                    : Column(
                        children: [
                          _buildJobDetailsPane(_selectedJob!),
                          const SizedBox(height: 30),
                          CareerIntakeForm(selectedJob: _selectedJob!),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    }

    if (Scaffold.maybeOf(context) != null) return dynamicBodyContent;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          AppLocalizations.of(context)?.translate('contact_appbar') ?? "Crewmanpower Gateway Hub",
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: dynamicBodyContent,
    );
  }

  Widget _buildJobCard(JobModel job) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildMetaChip(Icons.business_center_outlined, job.experience),
              _buildMetaChip(Icons.location_on_outlined, job.location),
              _buildMetaChip(Icons.payments_outlined, job.salary),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Role Summary Overview:",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0D47A1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => setState(() => _selectedJob = job),
              child: const Text(
                "Apply Now",
                style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF334155), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailsPane(JobModel job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: const Color(0xFFF1F5F9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow(Icons.business_center_rounded, "Experience Structure", job.experience),
                const Divider(height: 20),
                _buildDetailRow(Icons.map_rounded, "Primary Node Location", job.location),
                const Divider(height: 20),
                _buildDetailRow(Icons.monetization_on_rounded, "Compensation Matrix", job.salary),
                const Divider(height: 20),
                _buildDetailRow(Icons.people_outline_rounded, "Available Vacancies", job.vacancies),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Core Mandate Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
        ),
        const SizedBox(height: 10),
        Text(
          job.description,
          style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF475569)),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0D47A1), size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
      ],
    );
  }
}