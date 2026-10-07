import 'package:flutter/material.dart';
import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class ClientPowerSupportSection extends StatelessWidget {
  final bool isDesktop;
  final bool isDark;

  const ClientPowerSupportSection({
    super.key,
    required this.isDesktop,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final CmsService cmsService = CmsService();
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return StreamBuilder<List<CmsModel>>(
      stream: cmsService.getSectionData('client_power_support'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final list = snapshot.data ?? [];

        if (list.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 50 : 30,
            horizontal: isDesktop ? 40 : 16,
          ),
          color: activeColors.surface,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  separatorBuilder: (context, index) => Container(
                    width: 1,
                    height: 80,
                    color: Colors.grey.withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Container(
                      width: isDesktop ? 260 : 200,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.imageUrl.isNotEmpty)
                            Image.network(
                              item.imageUrl,
                              height: 42,
                              width: 42,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.star_rounded,
                                size: 36,
                                color: AppColors.primaryBlue,
                              ),
                            )
                          else
                            const Icon(
                              Icons.verified_rounded,
                              size: 36,
                              color: AppColors.primaryBlue,
                            ),
                          const SizedBox(height: 12),
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: isDesktop ? 28 : 22,
                              fontWeight: FontWeight.bold,
                              color: activeColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: activeColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}