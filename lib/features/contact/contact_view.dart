import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'contact_provider.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return ChangeNotifierProvider(
      create: (_) => ContactProvider(),
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<ContactProvider>();
          Widget content = SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: isDesktop ? 60 : 20,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _buildEnquiryInfoSection(context, activeColors, isDark),
                          ),
                          const SizedBox(width: 45),
                          Expanded(
                            flex: 5,
                            child: _buildFormCardWrapper(
                              context,
                              nameController,
                              phoneController,
                              emailController,
                              messageController,
                              provider,
                              activeColors,
                              isDark,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildEnquiryInfoSection(context, activeColors, isDark),
                          const SizedBox(height: 30),
                          _buildFormCardWrapper(
                            context,
                            nameController,
                            phoneController,
                            emailController,
                            messageController,
                            provider,
                            activeColors,
                            isDark,
                          ),
                        ],
                      ),
              ),
            ),
          );

          if (provider.lastSubmitSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green[800],
                  content: Text(
                    AppLocalizations.of(context)?.translate('contact_success_snack') ??
                        "Enquiry successfully transmitted to corporate grid.",
                  ),
                ),
              );
            });
            provider.lastSubmitSuccess = false;
          }

          if (Scaffold.maybeOf(ctx) != null) return content;

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: content,
          );
        },
      ),
    );
  }

  Widget _buildFormCardWrapper(
    BuildContext context,
    TextEditingController nameCtrl,
    TextEditingController phoneCtrl,
    TextEditingController emailCtrl,
    TextEditingController msgCtrl,
    dynamic provider,
    BaseThemeColors activeColors,
    bool isDark,
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
        provider: provider,
        activeColors: activeColors,
        isDark: isDark,
      ),
    );
  }

  Widget _buildEnquiryInfoSection(BuildContext context, BaseThemeColors activeColors, bool isDark) {
    // High contrast white for dark/blue gradient background
    final titleColor = Colors.white;
    final bodyColor = Colors.white.withOpacity(0.92);
    final subColor = Colors.white.withOpacity(0.80);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enquiry Assistance",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: titleColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Have specific questions regarding workforce allocation parameters? Drop your requirements, and our coordination command room will respond within 2 business hours.",
          style: TextStyle(
            fontSize: 15.5,
            color: bodyColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 35),
        _buildInfoTile(
          Icons.support_agent_rounded,
          "General Operations Desk",
          "+91 522 XXX XXXX / info@crewmanpower.com",
          titleColor,
          subColor,
        ),
        const SizedBox(height: 20),
        _buildInfoTile(
          Icons.verified_user_rounded,
          "Compliance & Security Audits",
          "compliance@crewmanpower.com",
          titleColor,
          subColor,
        ),
        const SizedBox(height: 20),
        _buildInfoTile(
          Icons.history_toggle_off_rounded,
          "Corporate Command Clock",
          "Monday - Saturday: 09:30 AM - 06:30 PM",
          titleColor,
          subColor,
        ),
      ],
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String subtitle,
    Color titleColor,
    Color subColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: subColor,
                  fontSize: 13.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final dynamic provider;
  final BaseThemeColors activeColors;
  final bool isDark;

  const ContactForm({
    super.key,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.provider,
    required this.activeColors,
    required this.isDark,
  });

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    // Light mode inside form card: Dark charcoal text & high contrast labels
    final inputTextColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final labelTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
    final fieldBgColor = isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);

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
            color: isDark ? const Color(0xFF475569) : const Color(0xFFE2E8F0),
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
    final cardTitleColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
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
            controller: nameCtrl,
            label: localizations?.translate('contact_name_label') ?? 'Full Name / Enterprise Identity',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: phoneCtrl,
            label: localizations?.translate('contact_phone_label') ?? 'Operational Contact Number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: emailCtrl,
            label: localizations?.translate('contact_email_label') ?? 'Official Email Address',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: msgCtrl,
            label: localizations?.translate('contact_message_label') ?? 'Describe Workforce Requirements',
            icon: Icons.description_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: 28),
          provider.isSubmitting
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
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
                      final success = await provider.submitInquiry(
                        type: 'general',
                        data: {
                          "name": nameCtrl.text,
                          "phone": phoneCtrl.text,
                          "email": emailCtrl.text,
                          "message": msgCtrl.text,
                        },
                      );
                      if (success) {
                        nameCtrl.clear();
                        phoneCtrl.clear();
                        emailCtrl.clear();
                        msgCtrl.clear();
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