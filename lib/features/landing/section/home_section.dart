import 'package:crewmanpower/features/landing/section/client_power_support_section.dart';
import 'package:crewmanpower/features/landing/section/our_team_section.dart';
import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/widgets/split_feature_section.dart';
import 'home_slider_widget.dart';
import 'why_choose_us_section.dart'; // Yahan widget import kiya gaya hai

class HomeSection extends StatelessWidget {
  final double screenWidth;
  final bool isDark;
  final Widget Function(BuildContext context, bool isDark)
  buildStatisticsSection;
  final VoidCallback onReachBottom;
  final VoidCallback? onContactUs;

  const HomeSection({
    super.key,
    required this.screenWidth,
    required this.isDark,
    required this.buildStatisticsSection,
    required this.onReachBottom,
    this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = screenWidth > 900;
    final CmsService cmsService = CmsService();

    return StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('home'),
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

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  HomeSliderWidget(
                    isDesktop: isDesktop,
                    isDark: isDark,
                    onReadMore: onReachBottom,
                    onContact: onContactUs,
                  ),
                  const SizedBox(height: 20),
                  if (list.isEmpty) ...[
                    SplitFeatureSection(
                      isDesktop: isDesktop,
                      imageRight: true,
                      badgeText: "GLOBAL PLACEMENT LEADER",
                      title:
                          "Empowering Industries With Premium Strategic Global Staffing",
                      description:
                          "Crewmanpower provisions end-to-end organizational talent architectures.",
                      mockupIcon: Icons.hub_outlined,
                      imageUrl:
                          "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=600",
                    ),
                  ] else ...[
                    ...list.asMap().entries.map((entry) {
                      int index = entry.key;
                      CmsModel item = entry.value;
                      bool imageOnRight = index % 2 == 0;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: SplitFeatureSection(
                          isDesktop: isDesktop,
                          imageRight: imageOnRight,
                          badgeText: item.subtitle.isNotEmpty
                              ? item.subtitle
                              : "",
                          title: item.title,
                          description: item.description,
                          mockupIcon: Icons.hub_outlined,
                          imageUrl: item.imageUrl.isNotEmpty
                              ? item.imageUrl
                              : "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=600",
                        ),
                      );
                    }),
                  ],

                  // Yahan WhyChooseUsSection ko call kar diya gaya hai
                  WhyChooseUsSection(isDesktop: isDesktop, isDark: isDark),
                  const SizedBox(height: 20),

                  ClientPowerSupportSection(
                    isDesktop: isDesktop,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 20),
                  OurTeamSection(isDesktop: isDesktop, isDark: isDark),
                  buildStatisticsSection(context, isDark),
                  const SizedBox(height: 100), // Extra spacing at bottom
                ],
              ),
            ),

            // Sleek Floating Next Button at Bottom Right of Home Section
            Positioned(
              bottom: 30,
              left: 30,
              child: FloatingActionButton.extended(
                onPressed: onReachBottom,
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                elevation: 6,
                icon: const Text(
                  "Next: About Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                label: const Icon(Icons.arrow_forward_rounded, size: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
