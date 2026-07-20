import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/app_localizations.dart';
import 'service_provider.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  // Maps service key identifiers directly to specific context icons dynamically
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
    return Icons.assignment_ind_rounded; // Default elegant fallback icon vector
  }

  // Returns precise human-readable fallback titles for the client demo view
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

  // Returns descriptive context values if fallback translation trees aren't initialized
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

          Widget content;
          if (keys.isEmpty) {
            content = const Center(
              child: Padding(
                padding: EdgeInsets.all(80.0),
                child: Text(
                  'No operational vectors discovered currently.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          } else {
            content = SingleChildScrollView(
              child: Column(
                children: [
                  // Premium Modern Gradient Dashboard Banner
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: isDesktop ? 80 : 50,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D47A1).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.blue.withOpacity(0.4)),
                          ),
                          child: const Text(
                            "CAPABILITIES",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)?.translate('services_title') ?? 'Services Spectrum',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
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
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Interactive Grid Block Layout Frame
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 80,
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
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 32,
                            childAspectRatio: isDesktop ? 1.25 : 1.45,
                          ),
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            final currentKey = keys[index];
                            return ServiceCard(
                              title: _mapServiceToTitle(context, currentKey),
                              description: _mapServiceToDesc(context, currentKey),
                              icon: _mapServiceToIcon(currentKey),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (Scaffold.maybeOf(ctx) != null) return content;

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: content,
          );
        },
      ),
    );
  }
}

/// Redesigned Responsive Interactive Card Component 
class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFF0D47A1);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 4),
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
                // Soft Accent Bounded Icon Hex Base Plate
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: brandColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: brandColor,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A), // Premium High-contrast Dark Slate
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B), // Clear Slate-500 Body Text Format
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action Vector Element Link
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Learn More',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 13,
                    color: brandColor,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_right_alt_rounded, 
                  size: 18, 
                  color: brandColor.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}