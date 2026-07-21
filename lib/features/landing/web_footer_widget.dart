import 'package:crewmanpower/core/helpers/social_media_links.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'package:crewmanpower/features/landing/footer_wave_painter.dart';
import 'package:flutter/material.dart';

class WebFooterWidget extends StatelessWidget {
  const WebFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    double width = MediaQuery.of(context).size.width;

    bool isDesktop = width > 950;
    bool isTablet = width <= 950 && width > 600;

    // Consuming AppColors directly: White text for Navy background, Dark text for Grey background
    final Color textColor = activeColors.footerTextColor;

    return IntrinsicHeight(
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: FooterWavePainter(
                backgroundColor: activeColors.footerWaveColor,
              ),
            ),
          ),
          // Foreground Content layer
          Container(
            width: width,
            color: Colors.transparent,
            padding: EdgeInsets.only(
              left: width > 1200 ? width * 0.08 : 24,
              right: width > 1200 ? width * 0.08 : 24,
              top: 130, // Safely pushes content below wave curve line
              bottom: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildBrandColumn(textTheme, textColor)),
                      const SizedBox(width: 30),
                      Expanded(child: _buildServicesColumn(textTheme, textColor)),
                      const SizedBox(width: 30),
                      Expanded(child: _buildHeadquartersColumn(textTheme, textColor)),
                      const SizedBox(width: 30),
                      Expanded(child: _buildSocialColumn(textColor)),
                    ],
                  )
                else if (isTablet)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildBrandColumn(textTheme, textColor)),
                          const SizedBox(width: 20),
                          Expanded(child: _buildServicesColumn(textTheme, textColor)),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildHeadquartersColumn(textTheme, textColor)),
                          const SizedBox(width: 20),
                          Expanded(child: _buildSocialColumn(textColor)),
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBrandColumn(textTheme, textColor),
                      const SizedBox(height: 30),
                      _buildServicesColumn(textTheme, textColor),
                      const SizedBox(height: 30),
                      _buildHeadquartersColumn(textTheme, textColor),
                      const SizedBox(height: 30),
                      _buildSocialColumn(textColor),
                    ],
                  ),
                const SizedBox(height: 40),
                Divider(color: textColor.withOpacity(0.25), height: 20),
                const SizedBox(height: 10),
                Text(
                  "© 2026 Crewmanpower Solutions. All Rights Reserved. Designed for elite industry scaling.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: textColor.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialColumn(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Connect With Us",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        const SocialMediaLinksColumn(),
      ],
    );
  }

  Widget _buildBrandColumn(TextTheme textTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CREWMANPOWER",
          style: textTheme.titleLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Leading provider of premium quality temporary and permanent workforce management systems globally.",
          style: textTheme.bodyMedium?.copyWith(
            color: textColor.withOpacity(0.85),
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesColumn(TextTheme textTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Core Services",
          style: textTheme.titleMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLinkItem("• Healthcare Staffing", textColor),
        _buildFooterLinkItem("• Security Services", textColor),
        _buildFooterLinkItem("• Housekeeping Staffing", textColor),
        _buildFooterLinkItem("• Corporate Staffing", textColor),
        _buildFooterLinkItem("• Facility Management", textColor),
      ],
    );
  }

  // FIX: Moved 'style' inside the Text widget properly
  Widget _buildFooterLinkItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          color: color.withOpacity(0.85),
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildHeadquartersColumn(TextTheme textTheme, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Head Office",
          style: textTheme.titleMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "1-B FIRST FLOOR,GALAXY TOWER,\nVIJAYANT KHAND,GOMTI NAGAR,\nLUCKNOW,UTTAR PRADESH - 226010",
          style: textTheme.bodyMedium?.copyWith(
            color: textColor.withOpacity(0.85),
            fontSize: 13,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}