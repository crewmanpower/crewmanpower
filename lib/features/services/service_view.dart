import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'service_provider.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  IconData _mapServiceToIcon(String key) {
    final lowerKey = key.toLowerCase();
    if (lowerKey.contains('manpower') || lowerKey.contains('staff')) {
      return Icons.badge_rounded;
    } else if (lowerKey.contains('security')) {
      return Icons.shield_rounded;
    } else if (lowerKey.contains('facility') || lowerKey.contains('housekeeping')) {
      return Icons.clean_hands_rounded;
    } else if (lowerKey.contains('hospital') || lowerKey.contains('medical')) {
      return Icons.health_and_safety_rounded;
    } else if (lowerKey.contains('logistics') || lowerKey.contains('warehouse')) {
      return Icons.precision_manufacturing_rounded;
    }
    return Icons.assignment_ind_rounded;
  }

  String _mapServiceToTitle(BuildContext context, String key) {
    final localized = AppLocalizations.of(context)?.translate(key);
    if (localized != null) return localized;

    switch (key) {
      case 'service_executive_search':
        return "Executive & Corporate Search";
      case 'service_industrial_staffing':
        return "Industrial Technical Staffing";
      case 'service_healthcare_support':
        return "Healthcare Logistics Support";
      case 'service_facility_management':
        return "Integrated Facility Engineering";
      default:
        return key.replaceAll('service_', '').replaceAll('_', ' ').toUpperCase();
    }
  }

  String _mapServiceToDesc(BuildContext context, String key) {
    final localized = AppLocalizations.of(context)?.translate('${key}_desc');
    if (localized != null) return localized;

    switch (key) {
      case 'service_executive_search':
        return "Identifying and deploying top-tier leadership asset configurations tailored precisely for scalable corporate structures.";
      case 'service_industrial_staffing':
        return "Vetted technical operational specialists, field technicians, and certified machinery handlers scaled on-demand.";
      case 'service_healthcare_support':
        return "Background-verified hospital support systems, certified clinical aid personnel, and nursing workforce management.";
      case 'service_facility_management':
        return "Premium asset preservation protocols, specialized corporate maintenance, and pristine commercial operational oversight.";
      default:
        return "High-yield strategic workforce optimization frameworks developed explicitly to match rigorous corporate compliance requirements.";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 900;
    int crossAxisCount = screenWidth > 1100 ? 3 : (screenWidth > 700 ? 2 : 1);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeColors = isDark ? AppColors.dark : AppColors.light;

    return ChangeNotifierProvider(
      create: (_) => ServiceProvider()
        ..loadServices(<String>[
          'service_executive_search',
          'service_industrial_staffing',
          'service_healthcare_support',
          'service_facility_management',
        ]),
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<ServiceProvider>();
          final keys = provider.services;

          Widget content = SingleChildScrollView(
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
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          "Deploying custom-engineered workforce solutions built on rigorous structural verification mechanisms and global compliance metrics.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: activeColors.textSecondary,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: screenWidth > 1300 ? screenWidth * 0.12 : 24,
                  ),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: isDesktop ? 1.25 : 1.4,
                        ),
                        itemCount: keys.length,
                        itemBuilder: (context, index) {
                          final currentKey = keys[index];
                          return ServiceCard(
                            title: _mapServiceToTitle(context, currentKey),
                            description: _mapServiceToDesc(context, currentKey),
                            icon: _mapServiceToIcon(currentKey),
                            activeColors: activeColors,
                          );
                        },
                      ),
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

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final BaseThemeColors activeColors;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.activeColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryBlue,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: activeColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: activeColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Learn More',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}