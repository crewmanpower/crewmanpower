import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/app_localizations.dart';
import 'industry_provider.dart';

class IndustryWebView extends StatefulWidget {
  const IndustryWebView({super.key});

  @override
  State<IndustryWebView> createState() => _IndustryWebViewState();
}

class _IndustryWebViewState extends State<IndustryWebView> {
  // Maps backend text-string identifier directly into active Flutter standard Material Icons
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

  // Returns precise fallbacks if AppLocalizations translation node is missing
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

  // Quick fallback descriptions to flesh out structural card balance beautifully
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
                // Premium Hero Section Banner
                Container(
                  width: double.infinity,
                  color: const Color(0xFF0A192F),
                  padding: EdgeInsets.symmetric(
                    vertical: isDesktop ? 90 : 60,
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[400]!.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "OUR EXPERTISE",
                          style: TextStyle(
                            color: Color(0xFF64FFDA), // Premium Teal Accent Color
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "INDUSTRIES WE CATER",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 42 : 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 650),
                        child: Text(
                          "Providing elite end-to-end workforce staffing solutions across diverse complex sectors on global operational scales.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Sector Allocation Content Grid
                if (industries.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(80.0),
                      child: Text(
                        "No tactical industrial configurations loaded.",
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth > 1300 ? screenWidth * 0.12 : 24,
                      vertical: 80,
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
            backgroundColor: const Color(0xFFF8FAFC),
            body: content,
          );
        },
      ),
    );
  }
}

/// Fully self-contained component handling clean interactive responsive layouts safely
class _IndustryGridCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _IndustryGridCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          // Soft Bounded Glass Icon Plate
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1).withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              size: 28,
              color: const Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B), // Soft Slate-500 body color
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}