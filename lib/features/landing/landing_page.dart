import 'dart:ui';

import 'package:crewmanpower/core/helpers/web_footer.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'package:crewmanpower/core/service/theems/theme_provider.dart';
import 'package:crewmanpower/core/widgets/build_image_icon.dart';
import 'package:crewmanpower/core/widgets/custom_nav_button.dart';
import 'package:crewmanpower/core/widgets/custom_drawer_card.dart';
import 'package:crewmanpower/core/widgets/split_feature_section.dart';
import 'package:crewmanpower/features/about/about_view.dart';
import 'package:crewmanpower/features/career/career_view.dart';
import 'package:crewmanpower/features/contact/contact_view.dart';
import 'package:crewmanpower/features/industry/industry_view.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/features/landing/horizontal_ticker_marquee.dart';
import 'package:crewmanpower/features/landing/web_footer_widget.dart';
import 'package:crewmanpower/features/marketing/marketing_view.dart';
import 'package:crewmanpower/features/services/service_view.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class WebLandingPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const WebLandingPage({super.key, required this.onLanguageChange});

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  int _activeSectionIndex = 0;
  bool _isChatOpen = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeThemeColors = isDark ? AppColors.dark : AppColors.light;

    Widget wrapWithFooter(Widget screenView) {
      double dynamicFooterHeight = screenWidth > 900 ? 480 : 950;
      double screenHeight = MediaQuery.of(context).size.height;
      double minHeight = math.max(0.0, screenHeight - dynamicFooterHeight);

      if (screenView is Scaffold) return screenView;

      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: minHeight),
              child: screenView,
            ),
            const WebFooterWidget(),
          ],
        ),
      );
    }

    final List<Widget> webSections = [
      wrapWithFooter(_buildMainHomeScreenStructure(context, screenWidth, isDark)),
      wrapWithFooter(const AboutView()),
      wrapWithFooter(const ServiceView()),
      wrapWithFooter(const IndustryWebView()),
      wrapWithFooter(const CareerView()),
      wrapWithFooter(const ContactView()),
      wrapWithFooter(const MarketingWebView()),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: activeThemeColors.gradientColors,
            stops: activeThemeColors.gradientStops,
          ),
        ),
        child: Column(
          children: [
            // Custom Navigation Header
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                color: AppColors.navyBackground.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      buildLogo(size: 38),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          "CREWMANPOWER",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (screenWidth > 850) ...[
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_home'),
                          isActive: _activeSectionIndex == 0,
                          onTap: () => setState(() => _activeSectionIndex = 0),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_about'),
                          isActive: _activeSectionIndex == 1,
                          onTap: () => setState(() => _activeSectionIndex = 1),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_services'),
                          isActive: _activeSectionIndex == 2,
                          onTap: () => setState(() => _activeSectionIndex = 2),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_industries'),
                          isActive: _activeSectionIndex == 3,
                          onTap: () => setState(() => _activeSectionIndex = 3),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_careers'),
                          isActive: _activeSectionIndex == 4,
                          onTap: () => setState(() => _activeSectionIndex = 4),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(context)!.translate('nav_contact'),
                          isActive: _activeSectionIndex == 5,
                          onTap: () => setState(() => _activeSectionIndex = 5),
                        ),
                      ],
                      const SizedBox(width: 10),
                      // Theme Switcher Button
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                            color: isDark ? Colors.white70 : Colors.black87,
                            size: 30,
                          ),
                          onPressed: () {
                            context.read<ThemeProvider>().toggleTheme();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Language Selector Dropdown
                      PopupMenuButton<String>(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.language,
                            color: isDark ? Colors.white70 : Colors.black87,
                            size: 20,
                          ),
                        ),
                        onSelected: (value) {
                          if (value == 'en') widget.onLanguageChange(const Locale('en'));
                          if (value == 'hi') widget.onLanguageChange(const Locale('hi'));
                          if (value == 'ur') widget.onLanguageChange(const Locale('ur'));
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(value: 'en', child: Text("English")),
                          const PopupMenuItem(value: 'hi', child: Text("हिंदी (Hindi)")),
                          const PopupMenuItem(value: 'ur', child: Text("اردو (Urdu)")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Page Body Content
            Expanded(
              child: Stack(
                children: [
                  webSections[_activeSectionIndex],
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isChatOpen) ...[
                          ImageIcons().buildImageIcon("assets/images/email.PNG", email),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon("assets/images/whatsapp.PNG", whatsapp),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon("assets/images/message.PNG", message),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon("assets/images/call.PNG", call),
                          const SizedBox(height: 15),
                        ],
                        FloatingActionButton(
                          backgroundColor: AppColors.primaryBlue,
                          elevation: 8,
                          onPressed: () => setState(() => _isChatOpen = !_isChatOpen),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: _isChatOpen
                                ? const Icon(Icons.close, color: Colors.white, key: ValueKey("close"))
                                : const Icon(Icons.chat_bubble_outline, color: Colors.white, key: ValueKey("chat")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: screenWidth <= 850
          ? CustomDrawerCard(
              activeIndex: _activeSectionIndex,
              onSectionSelected: (index) => setState(() => _activeSectionIndex = index),
            )
          : null,
    );
  }

  Widget _buildMainHomeScreenStructure(BuildContext context, double width, bool isDark) {
    bool isDesktop = width > 900;
    return Column(
      children: [
        SplitFeatureSection(
          isDesktop: isDesktop,
          imageRight: true,
          badgeText: "GLOBAL PLACEMENT LEADER",
          title: "Empowering Industries With Premium Strategic Global Staffing",
          description: "Crewmanpower provisions end-to-end organizational talent architectures. We systematically bridge human capability vectors with institutional engineering demands across advanced international corporate frameworks.",
          mockupIcon: Icons.hub_outlined,
          imageUrl: "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=600",
        ),
        _buildStatisticsSection(context, isDark),
        SplitFeatureSection(
          isDesktop: isDesktop,
          imageRight: false,
          badgeText: "Why Choose Crewmanpower?",
          title: "Uncompromising commitment to system reliability, multi-level checks, and resource acceleration scaling.",
          description: "Verified Personnel\nEvery staff member goes through multi-level background checks.\n\n24/7 Support Support\nOur central team is always ready to fulfill urgent resource requirements.\n\nFlexible Scalability\nEasily scale your temporary or permanent workers up or down.",
          mockupIcon: Icons.hub_outlined,
          imageUrl: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=600",
        ),
        SplitFeatureSection(
          isDesktop: isDesktop,
          imageRight: true,
          badgeText: "ENTERPRISE INTELLIGENCE",
          title: "Vetted Institutional Security & High-Yield Workspace Mechanics",
          description: "Our organizational logistics deployment ensures zero system disruption. Every professional personnel unit exhibits high alignment with asset preservation protocol standards and operational excellence blueprints.",
          mockupIcon: Icons.connect_without_contact_sharp,
          imageUrl: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=600",
        ),
        _buildTestimonialsSection(isDesktop, isDark),
      ],
    );
  }

  Widget _buildStatisticsSection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1600),
          decoration: BoxDecoration(
            // Subtly highlighted container box behind the marquee
            color: isDark 
                ? Colors.white.withOpacity(0.04) 
                : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(isDark ? 0.1 : 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 30,
                offset: const Offset(0, 10),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: HorizontalTickerMarquee(
                onItemTap: (index) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You clicked verified badge code: $index',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppColors.navyBackground,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialsSection(bool isDesktop, bool isDark) {
    final BaseThemeColors activeThemeColors = isDark ? AppColors.dark : AppColors.light;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isDesktop ? 60 : 24),
      // CHANGED: Set color to transparent instead of activeThemeColors.background
      color: Colors.transparent, 
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "TESTIMONIALS",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "What Our Clients Say",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 38 : 28,
              fontWeight: FontWeight.bold,
              color: activeThemeColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Trusted across sectors to deliver operational excellence and vetted compliance.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: activeThemeColors.textSecondary),
          ),
          const SizedBox(height: 56),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              TestimonialCard(
                client: "Operations Director\n(Leading Tech Infrastructure Firm)",
                review: "Crewmanpower completely transformed our active project operations. Their corporate facility and engineering office support staff units are exceptionally disciplined, vetted, and highly punctual.",
              ),
              TestimonialCard(
                client: "Chief Medical Administrator\n(Metro Super Specialty Hospital Network)",
                review: "Securing fully certified and background-verified clinical assistants during peak seasonal patient surges became completely stress-free once we deployed their institutional talent pipeline.",
              ),
            ],
          )
        ],
      ),
    );
  }
}