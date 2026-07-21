import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'industry_provider.dart';

class IndustryWebView extends StatefulWidget {
  const IndustryWebView({super.key});

  @override
  State<IndustryWebView> createState() => _IndustryWebViewState();
}

class _IndustryWebViewState extends State<IndustryWebView> {
  IconData _mapStringToIcon(String iconName) {
    switch (iconName) {
      case 'local_hospital':
        return Icons.local_hospital_rounded;
      case 'hotel':
        return Icons.hotel_rounded;
      case 'warehouse':
        return Icons.warehouse_rounded;
      case 'business':
        return Icons.business_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'factory':
        return Icons.factory_rounded;
      default:
        return Icons.domain_rounded;
    }
  }

  String _mapStringToTitle(BuildContext context, String key) {
    final localizedText = AppLocalizations.of(context)?.translate(key);
    if (localizedText != null) return localizedText;

    switch (key) {
      case 'industry_hospital_healthcare':
        return "Hospital & Healthcare";
      case 'industry_hotels_hospitality':
        return "Hotels & Hospitality";
      case 'industry_warehouses_logistics':
        return "Warehouses & Logistics";
      case 'industry_corporate_offices':
        return "Corporate Offices";
      case 'industry_security_surveillance':
        return "Security & Surveillance";
      case 'industry_manufacturing_factories':
        return "Manufacturing & Factories";
      default:
        return "Industrial Sector";
    }
  }

  String _getFallbackSub(String key) {
    switch (key) {
      case 'industry_hospital_healthcare':
        return "Vetted clinical assistants, medical receptionists, and support staff specialists.";
      case 'industry_hotels_hospitality':
        return "Front-desk executives, hospitality staff, culinary crews, and event talent.";
      case 'industry_warehouses_logistics':
        return "Inventory managers, logistics hands, sorting teams, and distribution crew.";
      case 'industry_corporate_offices':
        return "Administrative staff, operational assistants, and facility management experts.";
      case 'industry_security_surveillance':
        return "Background-verified surveillance personnel and secure access controllers.";
      case 'industry_manufacturing_factories':
        return "Assembling floor operators, machine handlers, and technical compliance crews.";
      default:
        return "Professional operational personnel scaled precisely to industry demands.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return ChangeNotifierProvider(
      create: (_) => IndustryProvider()
        ..loadIndustries(<Map<String, dynamic>>[
          {'icon': 'local_hospital', 'key': 'industry_hospital_healthcare'},
          {'icon': 'hotel', 'key': 'industry_hotels_hospitality'},
          {'icon': 'warehouse', 'key': 'industry_warehouses_logistics'},
          {'icon': 'business', 'key': 'industry_corporate_offices'},
          {'icon': 'security', 'key': 'industry_security_surveillance'},
          {'icon': 'factory', 'key': 'industry_manufacturing_factories'},
        ]),
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<IndustryProvider>();
          final industries = provider.industries;

          Widget content = SingleChildScrollView(
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

                // Sector Allocation Content Grid
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 1300 ? screenWidth * 0.12 : 24,
                    vertical: 40,
                  ),
                  child: Center(
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: industries.map((item) {
                        final String key = item['key'] ?? '';
                        final String iconStr = item['icon'] ?? '';

                        return _IndustryGridCard(
                          title: _mapStringToTitle(ctx, key),
                          subtitle: _getFallbackSub(key),
                          icon: _mapStringToIcon(iconStr),
                          activeColors: activeColors,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );

          if (Scaffold.maybeOf(ctx) != null) return content;

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: content,
          );
        },
      ),
    );
  }
}

class _IndustryGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final BaseThemeColors activeColors;

  const _IndustryGridCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.activeColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: activeColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activeColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: activeColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: activeColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}