import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class OurTeamSection extends StatelessWidget {
  final bool isDesktop;
  final bool isDark;

  const OurTeamSection({
    super.key,
    required this.isDesktop,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final CmsService cmsService = CmsService();
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('our_team'),
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
        if (list.isEmpty) return const SizedBox.shrink();

        // Header item fetch karne ke liye
        CmsModel? headerItem;
        try {
          headerItem = list.firstWhere((e) => e.contentType == 'header');
        } catch (_) {}

        // Profile / Director item fetch karne ke liye
        CmsModel? profileItem;
        try {
          profileItem = list.firstWhere((e) => e.contentType == 'image_description');
        } catch (_) {}

        // Gallery images fetch karne ke liye
        final imageItems = list.where((e) => e.contentType == 'image').toList();

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
                  // 1. Header Title & Description Section
                  if (headerItem != null) ...[
                    Text(
                      headerItem.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isDesktop ? 36 : 24,
                        fontWeight: FontWeight.bold,
                        color: activeColors.textPrimary,
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
                    const SizedBox(height: 50),
                  ],

                  // 2. Management Profile / Leader Card Section
                  if (profileItem != null) ...[
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: activeColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: activeColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Flex(
                        direction: isDesktop ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (profileItem.imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                profileItem.imageUrl,
                                height: isDesktop ? 280 : 220,
                                width: isDesktop ? 280 : double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(width: isDesktop ? 30 : 0, height: isDesktop ? 0 : 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (profileItem.title.isNotEmpty)
                                  Text(
                                    profileItem.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: activeColors.textPrimary,
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                Text(
                                  profileItem.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: activeColors.textSecondary,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],

                  // 3. Gallery Grid Section (4 items per row on Desktop, 2 on Small Screen)
                  if (imageItems.isNotEmpty) ...[
                    Text(
                      "Our Team Gallery",
                      style: TextStyle(
                        fontSize: isDesktop ? 28 : 22,
                        fontWeight: FontWeight.bold,
                        color: activeColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: imageItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 4 : 2, // Desktop par 4, mobile par 2
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        final img = imageItems[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: activeColors.border),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              img.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}