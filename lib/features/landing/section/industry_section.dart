import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class IndustryWebView extends StatelessWidget {
  const IndustryWebView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;
    
    // Full/Desktop screen par 2 columns, small screen par 1 column
    int crossAxisCount = screenWidth > 900 ? 2 : 1;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;
    final CmsService cmsService = CmsService();

    Widget content = StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('industries'),
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
              // Modern Hero Header Section
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
                        "OUR EXPERTISE",
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
                      "INDUSTRIES WE CATER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: activeColors.textPrimary,
                        fontSize: isDesktop ? 40 : 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 650),
                      child: Text(
                        "Providing elite end-to-end workforce staffing solutions across diverse complex sectors on global operational scales.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: activeColors.textSecondary,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Sector Allocation Content Grid (2 horizontal on desktop, 1 on small screen)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 1300 ? screenWidth * 0.1 : 24,
                  vertical: 20,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1300),
                    child: list.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Text(
                                "No industries configured yet by admin.",
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
                              childAspectRatio: screenWidth > 900 ? 1.3 : 1.2,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];
                              return _IndustryGridCard(
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

class _IndustryGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final BaseThemeColors activeColors;
  final bool isDark;

  const _IndustryGridCard({
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
              // Left side: Image instead of Icon
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 90,
                          height: 90,
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          child: const Icon(Icons.image_not_supported, color: AppColors.primaryBlue),
                        ),
                      )
                    : Container(
                        width: 90,
                        height: 90,
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        child: const Icon(Icons.business_rounded, color: AppColors.primaryBlue, size: 30),
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
                        color: activeColors.textPrimary,
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

          // Bottom: Full Description
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