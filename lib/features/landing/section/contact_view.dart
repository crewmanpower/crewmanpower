import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();
    
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;
    final CmsService cmsService = CmsService();

    return StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('contact'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final list = snapshot.data ?? [];

        Widget contactListContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "GET IN TOUCH",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Contact Our Corporate Hub",
              style: TextStyle(
                fontSize: isDesktop ? 38 : 26,
                fontWeight: FontWeight.bold,
                color: activeColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Reach out to our offices or operational units directly through our verified channels below.",
              style: TextStyle(
                fontSize: 15,
                color: activeColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),

            // Dynamic Contact Cards List
            list.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                        "No contact details published yet by admin.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: activeColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: activeColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.location_city_rounded, color: AppColors.primaryBlue, size: 28),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: activeColors.textPrimary,
                                    ),
                                  ),
                                  if (item.subtitle.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      item.subtitle,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryBlue,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 10),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        );

        Widget contactFormContent = _buildFormCardWrapper(
          context,
          nameController,
          phoneController,
          emailController,
          messageController,
          activeColors,
          isDark,
          cmsService,
        );

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 60 : 30,
            horizontal: isDesktop ? 60 : 20,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: contactListContent),
                        const SizedBox(width: 45),
                        Expanded(flex: 5, child: contactFormContent),
                      ],
                    )
                  : Column(
                      children: [
                        contactListContent,
                        const SizedBox(height: 40),
                        contactFormContent,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormCardWrapper(
    BuildContext context,
    TextEditingController nameCtrl,
    TextEditingController phoneCtrl,
    TextEditingController emailCtrl,
    TextEditingController msgCtrl,
    BaseThemeColors activeColors,
    bool isDark,
    CmsService cmsService,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: activeColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: activeColors.border),
      ),
      child: ContactForm(
        nameCtrl: nameCtrl,
        phoneCtrl: phoneCtrl,
        emailCtrl: emailCtrl,
        msgCtrl: msgCtrl,
        activeColors: activeColors,
        isDark: isDark,
        cmsService: cmsService,
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final BaseThemeColors activeColors;
  final bool isDark;
  final CmsService cmsService;

  const ContactForm({
    super.key,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.activeColors,
    required this.isDark,
    required this.cmsService,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  bool _isSubmitting = false;

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final inputTextColor = widget.isDark ? Colors.white : const Color(0xFF0F172A);
    final labelTextColor = widget.isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
    final fieldBgColor = widget.isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(
        color: inputTextColor,
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelTextColor,
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(icon, color: AppColors.primaryBlue, size: 22),
        filled: true,
        fillColor: fieldBgColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final cardTitleColor = widget.isDark ? Colors.white : const Color(0xFF0F172A);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations?.translate('contact_request') ?? 'Submit Intake Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cardTitleColor,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            controller: widget.nameCtrl,
            label: localizations?.translate('contact_name_label') ?? 'Full Name / Enterprise Identity',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: widget.phoneCtrl,
            label: localizations?.translate('contact_phone_label') ?? 'Operational Contact Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: widget.emailCtrl,
            label: localizations?.translate('contact_email_label') ?? 'Official Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: widget.msgCtrl,
            label: localizations?.translate('contact_message_label') ?? 'Describe Workforce Requirements',
            icon: Icons.description_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: 28),
          _isSubmitting
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      if (widget.nameCtrl.text.trim().isEmpty || widget.phoneCtrl.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text("Kripya naam aur contact number zaroor bharein."),
                          ),
                        );
                        return;
                      }

                      setState(() => _isSubmitting = true);

                      try {
                        await widget.cmsService.submitGeneralInquiry(
                          name: widget.nameCtrl.text.trim(),
                          phone: widget.phoneCtrl.text.trim(),
                          email: widget.emailCtrl.text.trim(),
                          message: widget.msgCtrl.text.trim(),
                        );

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Aapki enquiry safalpurvak database mein save ho gayi hai!"),
                            ),
                          );
                          widget.nameCtrl.clear();
                          widget.phoneCtrl.clear();
                          widget.emailCtrl.clear();
                          widget.msgCtrl.clear();
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Enquiry save karne mein error aaya: $e"),
                            ),
                          );
                        }
                      } finally {
                        if (context.mounted) {
                          setState(() => _isSubmitting = false);
                        }
                      }
                    },
                    child: Text(
                      localizations?.translate('contact_submit') ?? 'Transmit Enquiry',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}