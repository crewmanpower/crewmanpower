import 'package:flutter/material.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class SplitFeatureSection extends StatelessWidget {
  final bool isDesktop;
  final bool imageRight;
  final String badgeText;
  final String title;
  final String description;
  final IconData mockupIcon;
  final String? imageUrl;

  const SplitFeatureSection({
    super.key,
    required this.isDesktop,
    required this.imageRight,
    required this.badgeText,
    required this.title,
    required this.description,
    required this.mockupIcon,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    // Use AppColors: Black in light mode, White in dark mode
    final titleTextColor = activeColors.textPrimary;
    final descTextColor = activeColors.textSecondary;
    final cardBgColor = activeColors.surface.withOpacity(isDark ? 0.85 : 0.95);

    Widget textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
          ),
          child: Text(
            badgeText,
            style: const TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: isDesktop ? 30 : 20,
            fontWeight: FontWeight.bold,
            color: titleTextColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: descTextColor,
            height: 1.6,
          ),
        ),
      ],
    );

    Widget showcaseGraphicBlock = Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isDesktop ? 0 : 320),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activeColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: activeColors.accentContainer,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 48,
                      color: activeColors.textSecondary,
                    ),
                  );
                },
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      mockupIcon,
                      size: 200,
                      color: AppColors.primaryBlue.withOpacity(0.05),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue.withOpacity(0.03),
                          AppColors.primaryBlue.withOpacity(0.08),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(mockupIcon, size: 56, color: AppColors.primaryBlue),
                        const SizedBox(height: 14),
                        Text(
                          "Interactive Interface Blueprint",
                          style: TextStyle(
                            color: titleTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Production System Module Active",
                          style: TextStyle(
                            color: descTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isDesktop ? 60 : 24,
      ),
      color: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (imageRight) ...[
                        Expanded(child: Center(child: textBlock)),
                        const SizedBox(width: 80),
                        Expanded(child: showcaseGraphicBlock),
                      ] else ...[
                        Expanded(child: showcaseGraphicBlock),
                        const SizedBox(width: 80),
                        Expanded(child: Center(child: textBlock)),
                      ]
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    showcaseGraphicBlock,
                    const SizedBox(height: 40),
                    textBlock,
                  ],
                ),
        ),
      ),
    );
  }
}