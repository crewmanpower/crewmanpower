import 'package:crewmanpower/core/model/job_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CareerIntakeForm extends StatefulWidget {
  final JobModel selectedJob;

  const CareerIntakeForm({super.key, required this.selectedJob});

  @override
  State<CareerIntakeForm> createState() => _CareerIntakeFormState();
}

class _CareerIntakeFormState extends State<CareerIntakeForm> {
  final _formKey = GlobalKey<FormState>();
  final JobService _jobService = JobService();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobController;
  late final TextEditingController _portfolioController;
  late final TextEditingController _coverLetterController;

  PlatformFile? _pickedResumeFile;
  bool _isSubmitting = false;

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
      // FIXED: Using direct static FilePicker.pickFiles method for older/compatible package versions
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 24),
            _buildInputField(
              controller: _nameController,
              label: "Full Name",
              icon: Icons.person_outline_rounded,
              validator: (v) => v!.isEmpty ? "Identity registration token required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _emailController,
              label: "Email Address",
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v!.isEmpty || !v.contains('@') ? "Valid email configuration vector required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _phoneController,
              label: "WhatsApp / Contact Number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? "Operational communication route required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _jobController,
              label: "Applying For Position",
              icon: Icons.work_outline_rounded,
              readOnly: true,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _portfolioController,
              label: "Portfolio / LinkedIn Link Matrix",
              icon: Icons.link_rounded,
              validator: (v) => v!.isEmpty ? "Resource validation pointer required" : null,
            ),
            const SizedBox(height: 18),
            _buildInputField(
              controller: _coverLetterController,
              label: "Cover Letter Introduction / Message",
              icon: Icons.description_outlined,
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            const Text(
              "Curriculum Vitae Document (PDF Requirement Only)",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _handleFileSelection,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _pickedResumeFile != null ? const Color(0xFF0D47A1) : const Color(0xFFCBD5E1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _pickedResumeFile != null ? Icons.picture_as_pdf_rounded : Icons.cloud_upload_outlined,
                      color: _pickedResumeFile != null ? const Color(0xFF0D47A1) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _pickedResumeFile != null ? _pickedResumeFile!.name : "Select PDF Document Asset",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _pickedResumeFile != null ? const Color(0xFF0D47A1) : const Color(0xFF64748B),
                          fontWeight: _pickedResumeFile != null ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_pickedResumeFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text("Validation Failure: Please select a PDF resume file."),
                              ),
                            );
                            return;
                          }

                          setState(() => _isSubmitting = true);

                          try {
                            await _jobService.applyForJob(
                              jobId: widget.selectedJob.id,
                              jobTitle: widget.selectedJob.title,
                              fullName: _nameController.text.trim(),
                              whatsappNumber: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              message: _coverLetterController.text.trim(),
                              linkedinUrl: _portfolioController.text.trim(),
                              resumeName: _pickedResumeFile!.name,
                            );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Application successfully transmitted to corporate grid!"),
                                ),
                              );
                              setState(() {
                                _nameController.clear();
                                _emailController.clear();
                                _phoneController.clear();
                                _portfolioController.clear();
                                _coverLetterController.clear();
                                _pickedResumeFile = null;
                              });
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Error submitting application: $e"),
                                ),
                              );
                            }
                          } finally {
                            if (context.mounted) {
                              setState(() => _isSubmitting = false);
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Transmit Application Portfolio",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.5),
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
            ? Padding(padding: const EdgeInsets.only(bottom: 55), child: Icon(icon))
            : Icon(icon),
        filled: true,
        fillColor: readOnly ? const Color(0xFFE2E8F0) : const Color(0xFFF8FAFC),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
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