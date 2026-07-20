import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// localized strings are used via AppLocalizations in widgets; keep import for usage
import 'about_provider.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 900;

    return ChangeNotifierProvider(
      create: (_) {
        final p = AboutProvider();
        p.loadAboutData();
        return p;
      },
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<AboutProvider>();

          final String mission = provider.companyMission;
          final String vision = provider.companyVision;
          final String directMessage = provider.directMessage;
          final List<Map<String, String>> timeline =
              provider.timelineMilestones;
          final List<String> certs = provider.certificationsList;

          Widget content = SingleChildScrollView(
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

                    // MISSION & VISION SECTION
                    isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SectionCard(
                                  title: "Our Mission",
                                  body: mission,
                                  icon: Icons.rocket_launch,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: SectionCard(
                                  title: "Our Vision",
                                  body: vision,
                                  icon: Icons.remove_red_eye,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SectionCard(
                                title: "Our Mission",
                                body: mission,
                                icon: Icons.rocket_launch,
                              ),
                              const SizedBox(height: 20),
                              SectionCard(
                                title: "Our Vision",
                                body: vision,
                                icon: Icons.remove_red_eye,
                              ),
                            ],
                          ),
                    const SizedBox(height: 40),

                    // DIRECT MESSAGE FROM MANAGEMENT
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border(
                          left: BorderSide(width: 6, color: Colors.blue[900]!),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Direct Message from Leadership",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "\"$directMessage\"",
                            style: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // CORPORATE TIMELINE / HISTORY
                    const Text(
                      "Our Journey Timeline",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...timeline.map(
                      (node) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "[${node['year']}] ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[800],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                node['detail']!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // OFFICIAL CERTIFICATIONS
                    const Text(
                      "Accreditations & Certifications",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: certs
                          .map(
                            (cert) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    cert,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );

          if (Scaffold.maybeOf(ctx) != null) return content;

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
        },
      ),
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
