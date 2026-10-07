import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class ServiceView extends StatelessWidget {
  const ServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;
    
    int crossAxisCount = screenWidth > 900 ? 2 : 1;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;
    final CmsService cmsService = CmsService();

    Widget content = StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('services'),
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: isDesktop ? 80 : 50,
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "CAPABILITIES",
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
                      AppLocalizations.of(context)?.translate('services_title') ?? 'Services Spectrum',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: activeColors.textPrimary,
                        fontSize: isDesktop ? 40 : 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: screenWidth > 1300 ? screenWidth * 0.1 : 24,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1300),
                    child: list.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Text(
                                "No services configured yet by admin.",
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              childAspectRatio: screenWidth > 900 ? 1.2 : 1.1,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              return ServiceCard(
                                title: item.title,
                                subtitle: item.subtitle,
                                description: item.description,
                                imageUrl: item.imageUrl,
                                activeColors: activeColors,
                                isDark: isDark,
                              );
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (Scaffold.maybeOf(context) != null) return content;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: content,
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final BaseThemeColors activeColors;
  final bool isDark;

  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.activeColors,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: activeColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activeColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          child: const Icon(Icons.image_not_supported, color: AppColors.primaryBlue),
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        child: const Icon(Icons.design_services_rounded, color: AppColors.primaryBlue, size: 28),
                      ),
              ),
              const SizedBox(width: 16),

              // Right side: Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black87,
                        letterSpacing: -0.3,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          
          // Bottom: Full Description with proper theme-aware dark text color
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}