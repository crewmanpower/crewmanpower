import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                            child: _buildEnquiryInfoSection(context),
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
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildEnquiryInfoSection(context),
                          const SizedBox(height: 30),
                          _buildFormCardWrapper(
                            context,
                            nameController,
                            phoneController,
                            emailController,
                            messageController,
                            provider,
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
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                AppLocalizations.of(context)?.translate('contact_appbar') ??
                    "Connect With Crewmanpower",
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
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
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: ContactForm(
        nameCtrl: nameCtrl,
        phoneCtrl: phoneCtrl,
        emailCtrl: emailCtrl,
        msgCtrl: msgCtrl,
        provider: provider,
      ),
    );
  }

  Widget _buildEnquiryInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enquiry Assistance",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Have specific questions regarding workforce allocation parameters? Drop your requirements, and our coordination command room will respond within 2 business hours.",
          style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.6),
        ),
        const SizedBox(height: 35),
        _buildInfoTile(
          Icons.support_agent_rounded,
          "General Operations Desk",
          "+91 522 XXX XXXX / info@crewmanpower.com",
        ),
        const SizedBox(height: 20),
        _buildInfoTile(
          Icons.verified_user_rounded,
          "Compliance & Security Audits",
          "compliance@crewmanpower.com",
        ),
        const SizedBox(height: 20),
        _buildInfoTile(
          Icons.history_toggle_off_rounded,
          "Corporate Command Clock",
          "Monday - Saturday: 09:30 AM - 06:30 PM",
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1).withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF0D47A1), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
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

  const ContactForm({
    Key? key,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            localizations?.translate('contact_request') ?? 'Submit Intake Profile',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameCtrl,
            decoration: InputDecoration(
              labelText: localizations?.translate('contact_name_label') ??
                  'Full Name / Enterprise Identity',
              prefixIcon: const Icon(Icons.person_outline_rounded),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: localizations?.translate('contact_phone_label') ??
                  'Operational Contact Number',
              prefixIcon: const Icon(Icons.phone_outlined),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: localizations?.translate('contact_email_label') ??
                  'Official Email Address',
              prefixIcon: const Icon(Icons.email_outlined),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: msgCtrl,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: localizations?.translate('contact_message_label') ??
                  'Describe Workforce Requirements',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Icon(Icons.description_outlined),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          provider.isSubmitting
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 48,
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
                      final success = await provider.submitInquiry(
                        type: 'general', // Pass a generic or single standard layout identifier here
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