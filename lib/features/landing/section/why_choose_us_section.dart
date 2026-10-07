import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class WhyChooseUsSection extends StatelessWidget {
  final bool isDesktop;
  final bool isDark;

  const WhyChooseUsSection({
    super.key,
    required this.isDesktop,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final CmsService cmsService = CmsService();
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('why_choose_us'),
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

        if (list.isEmpty) {
          return const SizedBox.shrink();
        }

        // Header item jiska contentType 'header' hai
        CmsModel? headerItem;
        try {
          headerItem = list.firstWhere((item) => item.contentType == 'header');
        } catch (_) {
          headerItem = list.isNotEmpty ? list.first : null;
        }

        // Feature items jinka contentType 'feature' hai
        final featureItems = list.where((item) => item.contentType == 'feature').toList();

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 60 : 30,
            horizontal: isDesktop ? 60 : 20,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Subtitle / Section Tag (e.g., WHY CHOOSE US ?)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "WHY CHOOSE US ?",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Main Heading Title
                  if (headerItem != null) ...[
                    Text(
                      headerItem.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isDesktop ? 36 : 24,
                        fontWeight: FontWeight.bold,
                        color: activeColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        headerItem.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: activeColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 50),

                  // Feature Cards Grid / List
                  featureItems.isEmpty
                      ? const Text("No features added yet.", style: TextStyle(color: Colors.grey))
                      : Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.center,
                          children: featureItems.map((feature) {
                            return Container(
                              width: isDesktop ? 270 : double.infinity,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon / Image
                                  if (feature.imageUrl.isNotEmpty)
                                    Image.network(
                                      feature.imageUrl,
                                      height: 50,
                                      width: 50,
                                      errorBuilder: (context, error, stackTrace) => const Icon(
                                        Icons.star_rounded,
                                        size: 40,
                                        color: AppColors.primaryBlue,
                                      ),
                                    )
                                  else
                                    const Icon(
                                      Icons.verified_rounded,
                                      size: 40,
                                      color: AppColors.primaryBlue,
                                    ),
                                  const SizedBox(height: 20),

                                  // Feature Title
                                  Text(
                                    feature.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: activeColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Feature Description
                                  Text(
                                    feature.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      color: activeColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}