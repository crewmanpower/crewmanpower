import 'package:crewmanpower/core/helpers/social_media_links.dart';
import 'package:crewmanpower/core/widgets/build_footer_link.dart';
import 'package:crewmanpower/features/landing/footer_wave_painter.dart';
import 'package:flutter/material.dart';

class WebFooterWidget extends StatelessWidget {
  const WebFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    double width = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    bool isDesktop = width > 950;
    bool isTablet = width <= 950 && width > 600;

    // We can assume the wave draws the background color using the scheme's primary container,
    // secondary container, or surface variant. Let's make text fallback onto colorScheme.onInverseSurface 
    // or colorScheme.onPrimary depending on your design choice. For dark footer motifs, onPrimary or onSecondaryContainer works perfectly.
    final textColor = colorScheme.onPrimary; 

    return IntrinsicHeight(
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: FooterWavePainter(
                // Dynamically passes the background color from your app theme
                backgroundColor: colorScheme.primaryContainer, 
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
              top: 130, // Safely pushes content below the 120px wave curve line
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
                      Expanded(child: _buildSocialColumn()),
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
                          Expanded(child: _buildSocialColumn()),
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
                      _buildSocialColumn(),
                    ],
                  ),
                const SizedBox(height: 40),
                Divider(color: theme.dividerColor.withOpacity(0.4), height: 20),
                const SizedBox(height: 10),
                Text(
                  "© 2026 Crewmanpower Solutions. All Rights Reserved. Designed for elite industry scaling.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: textColor.withOpacity(0.6),
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

  Widget _buildSocialColumn() {
    return const SocialMediaLinksColumn();
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
            color: textColor.withOpacity(0.75), 
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
        buildFooterLink("• Healthcare Staffing"),
        buildFooterLink("• Security Services"),
        buildFooterLink("• Housekeeping Staffing"),
        buildFooterLink("• Corporate Staffing"),
        buildFooterLink("• Facility Management"),
      ],
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
            color: textColor.withOpacity(0.75), 
            fontSize: 13, 
            height: 1.6, 
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}