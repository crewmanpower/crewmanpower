import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;
    final CmsService cmsService = CmsService();

    Widget content = StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('about'),
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

        return SingleChildScrollView(
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
                  // COMPANY INTRODUCTION
                  const Text(
                    "Who We Are",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Crewmanpower Solutions is an industry-leading workforce operations agency. We specialize in providing highly responsive, fully compliant, and background-verified manpower across critical corporate, medical, and industrial paradigms.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // DYNAMIC CMS CARDS FROM FIREBASE
                  list.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "No about content published yet by admin.",
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
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SectionCard(
                                title: item.title,
                                body: item.description,
                                icon: Icons.rocket_launch,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (Scaffold.maybeOf(context) != null) return content;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "About Crewmanpower",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: content,
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;

  const SectionCard({
    Key? key,
    required this.title,
    required this.body,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}