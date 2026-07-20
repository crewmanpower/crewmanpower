import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/features/career/career_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class JobModel {
  final String title;
  final String experience;
  final String location;
  final String salary;
  final List<String> skills;
  final String description;

  const JobModel({
    required this.title,
    required this.experience,
    required this.location,
    required this.salary,
    required this.skills,
    required this.description,
  });
}

class CareerView extends StatefulWidget {
  const CareerView({super.key});

  @override
  State<CareerView> createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {
  // Global Mock Repository representing the active corporate listings matrix
  final List<JobModel> _mockJobs = const [
    JobModel(
      title: "Flutter Mobile Developer",
      experience: "2 to 3 Years",
      location: "Lucknow",
      salary: "10 LPA to 14 LPA",
      skills: ["Flutter", "Dart", "BLoC", "Firebase", "REST APIs"],
      description:
          "We are actively scouting for a talented Flutter Developer capable of engineering clean architectural mobile solutions. You will be responsible for creating highly reactive interfaces, managing state profiles cleanly via business logic modules, and ensuring top tier deployment standards across multi-platform structures.",
    ),
    JobModel(
      title: "Full-Stack Software Engineer",
      experience: "3+ Years Required",
      location: "Lucknow",
      salary: "12 LPA to 18 LPA",
      skills: ["Node.js", "React.js", "MongoDB", "AWS", "TypeScript"],
      description:
          "Join our primary systems framework team to construct scalable architecture nodes. Responsible for modern web design interfaces alongside secure microservice integrations.",
    ),
    JobModel(
      title: "QA Automation Tester",
      experience: "Freshers / Interns Welcome",
      location: "Lucknow",
      salary: "4 LPA to 6 LPA",
      skills: ["Selenium", "Appium", "Postman", "Dart Automation"],
      description:
          "Seeking precision-driven analytical minds to reinforce validation suites. Write rigorous automated integration scripts and oversee system stress limits prior to deployment cycles.",
    ),
    JobModel(
      title: "Senior Project Manager",
      experience: "5+ Years",
      location: "Lucknow",
      salary: "16 LPA to 22 LPA",
      skills: ["Agile", "Scrum Master", "Jira", "Sprint Logistics"],
      description:
          "Direct enterprise resource workflows and establish operational synergy milestones across product horizons.",
    ),
  ];

  // Currently focused entity tracking state
  JobModel? _selectedJob;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;

    return ChangeNotifierProvider(
      create: (_) => CareerProvider(),
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<CareerProvider>();

          if (provider.isApplying) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green[800],
                  content: Text(
                    AppLocalizations.of(
                          context,
                        )?.translate('contact_success_snack') ??
                        "Application package successfully transmitted to corporate grid.",
                  ),
                ),
              );
              setState(() {
                _selectedJob =
                    null; // Route workflow smoothly back to listings grid
              });
            });
            provider.isApplying = false;
          }

          Widget dynamicBodyContent;

          if (_selectedJob == null) {
            // Screen state A: Render elegant multi-column operational cards matrix
            int crossAxisCount = width > 1200 ? 3 : (width > 750 ? 2 : 1);
            double aspectRatio = width > 1200
                ? 1.35
                : (width > 750 ? 1.25 : 1.4);

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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: aspectRatio,
                        ),
                        itemCount: _mockJobs.length,
                        itemBuilder: (context, index) {
                          return _buildJobCard(_mockJobs[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Screen state B: Clean Split Dashboard Detail Intake Frame Template
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
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0D47A1),
                        ),
                        label: const Text(
                          "Return to Listings",
                          style: TextStyle(
                            color: Color(0xFF0D47A1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: _buildJobDetailsPane(_selectedJob!),
                                ),
                                const SizedBox(width: 45),
                                Expanded(
                                  flex: 5,
                                  child: CareerIntakeForm(
                                    selectedJob: _selectedJob!,
                                    provider: provider,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildJobDetailsPane(_selectedJob!),
                                const SizedBox(height: 30),
                                CareerIntakeForm(
                                  selectedJob: _selectedJob!,
                                  provider: provider,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (Scaffold.maybeOf(ctx) != null) return dynamicBodyContent;

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                AppLocalizations.of(context)?.translate('contact_appbar') ??
                    "Crewmanpower Gateway Hub",
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            body: dynamicBodyContent,
          );
        },
      ),
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
          // Structured metadata badge chips mapping row metrics
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
            "Target Competencies:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: job.skills
                    .map(
                      (s) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D47A1).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          s,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF0D47A1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF0D47A1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => setState(() => _selectedJob = job),
              child: const Text(
                "Apply Now",
                style: TextStyle(
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                ),
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
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
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
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: const Color(0xFFF1F5F9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow(
                  Icons.business_center_rounded,
                  "Experience Structure",
                  job.experience,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  Icons.map_rounded,
                  "Primary Node Location",
                  job.location,
                ),
                const Divider(height: 20),
                _buildDetailRow(
                  Icons.monetization_on_rounded,
                  "Compensation Matrix",
                  job.salary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Core Mandate Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          job.description,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Required Skill Index",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: job.skills
              .map(
                (s) => Chip(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  label: Text(
                    s,
                    style: const TextStyle(color: Color(0xFF334155)),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0D47A1), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

/// Dynamic State Tracking form logic controller class wrapper
class CareerIntakeForm extends StatefulWidget {
  final JobModel selectedJob;
  final dynamic provider;

  const CareerIntakeForm({
    super.key,
    required this.selectedJob,
    required this.provider,
  });

  @override
  State<CareerIntakeForm> createState() => _CareerIntakeFormState();
}

class _CareerIntakeFormState extends State<CareerIntakeForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobController;
  late final TextEditingController _portfolioController;
  late final TextEditingController _coverLetterController;

  PlatformFile? _pickedResumeFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _jobController = TextEditingController(text: widget.selectedJob.title);
    _portfolioController = TextEditingController();
    _coverLetterController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant CareerIntakeForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedJob.title != widget.selectedJob.title) {
      _jobController.text = widget.selectedJob.title;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _portfolioController.dispose();
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _handleFileSelection() async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _pickedResumeFile = result.files.first;
        });
      }
    } catch (e) {
      debugPrint("File selection sequence fault: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Application Profile Intake",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 24),
            _buildInputField(
              controller: _nameController,
              label: "Full Name",
              icon: Icons.person_outline_rounded,
              validator: (v) =>
                  v!.isEmpty ? "Identity registration token required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _emailController,
              label: "Email Address",
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v!.isEmpty || !v.contains('@')
                  ? "Valid email configuration vector required"
                  : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _phoneController,
              label: "Contact Number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty
                  ? "Operational communication route required"
                  : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _jobController,
              label: "Applying For Position",
              icon: Icons.work_outline_rounded,
              readOnly: true, // Auto-locked based on listing chosen
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _portfolioController,
              label: "Portfolio / LinkedIn Link Matrix",
              icon: Icons.link_rounded,
              validator: (v) =>
                  v!.isEmpty ? "Resource validation pointer required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _coverLetterController,
              label: "Cover Letter Introduction",
              icon: Icons.description_outlined,
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Premium Dedicated Document Upload Container Box
            const Text(
              "Curriculum Vitae Document (PDF Requirement Only)",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _handleFileSelection,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _pickedResumeFile != null
                        ? const Color(0xFF0D47A1)
                        : const Color(0xFFCBD5E1),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _pickedResumeFile != null
                          ? Icons.picture_as_pdf_rounded
                          : Icons.cloud_upload_outlined,
                      color: _pickedResumeFile != null
                          ? const Color(0xFF0D47A1)
                          : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _pickedResumeFile != null
                            ? _pickedResumeFile!.name
                            : "Select PDF Document Asset",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _pickedResumeFile != null
                              ? const Color(0xFF0D47A1)
                              : const Color(0xFF64748B),
                          fontWeight: _pickedResumeFile != null
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            widget.provider.isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_pickedResumeFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  "Validation Failure: Please append a required PDF resume file resource.",
                                ),
                              ),
                            );
                            return;
                          }

                          await widget.provider.submitInquiry(
                            type: 'career_application',
                            data: {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "phone": _phoneController.text,
                              "position": _jobController.text,
                              "portfolio": _portfolioController.text,
                              "cover_letter": _coverLetterController.text,
                              "resume_name": _pickedResumeFile!.name,
                              "resume_bytes": _pickedResumeFile!
                                  .bytes, // Ready for transmission payload
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Transmit Application Portfolio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        prefixIcon: maxLines > 1
            ? Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: Icon(icon),
              )
            : Icon(icon),
        filled: true,
        fillColor: readOnly ? const Color(0xFFE2E8F0) : const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 1.5),
        ),
      ),
    );
  }
}