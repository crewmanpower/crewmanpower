import 'dart:ui';

import 'package:crewmanpower/core/helpers/web_footer.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'package:crewmanpower/core/service/theems/theme_provider.dart';
import 'package:crewmanpower/core/widgets/build_image_icon.dart';
import 'package:crewmanpower/core/widgets/custom_nav_button.dart';
import 'package:crewmanpower/core/widgets/custom_drawer_card.dart';
import 'package:crewmanpower/features/landing/section/about_section.dart';
import 'package:crewmanpower/features/landing/section/career_section.dart';
import 'package:crewmanpower/features/landing/section/contact_view.dart';
import 'package:crewmanpower/features/landing/section/industry_section.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:crewmanpower/features/landing/section/home_section.dart';
import 'package:crewmanpower/features/landing/horizontal_ticker_marquee.dart';
import 'package:crewmanpower/features/landing/web_footer_widget.dart';
import 'package:crewmanpower/features/marketing/marketing_view.dart';
import 'package:crewmanpower/features/landing/section/service_section.dart';
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

  void email() {
    debugPrint("Email icon clicked");
  }

  void whatsapp() {
    debugPrint("WhatsApp icon clicked");
  }

  void message() {
    debugPrint("Message icon clicked");
  }

  void call() {
    debugPrint("Call icon clicked");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final BaseThemeColors activeThemeColors = isDark
        ? AppColors.dark
        : AppColors.light;

    Widget wrapWithFooter(Widget screenView) {
      double dynamicFooterHeight = screenWidth > 950 ? 480 : 950;
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
      wrapWithFooter(
        HomeSection(
          screenWidth: screenWidth,
          isDark: isDark,
          buildStatisticsSection: (context, dark) =>
              _buildStatisticsSection(context, dark),
          onContactUs: () {
            setState(() {
              _activeSectionIndex = 5;
            });
          },
          onReachBottom: () {
            if (_activeSectionIndex == 0) {
              setState(() {
                _activeSectionIndex =
                    1; // Auto switch to About Us section smoothly
              });
            }
          },
        ),
      ),
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
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF112240).withOpacity(0.95)
                    : Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
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
                      if (screenWidth <= 950) ...[
                        Builder(
                          builder: (context) => IconButton(
                            icon: Icon(
                              Icons.menu_rounded,
                              color: isDark ? Colors.white : Colors.black87,
                              size: 26,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      buildLogo(size: 38),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          "CREWMANPOWER",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: isDark
                                ? Colors.blue[300]
                                : AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth > 400 ? 20 : 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (screenWidth > 950) ...[
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_home'),
                          isActive: _activeSectionIndex == 0,
                          onTap: () => setState(() => _activeSectionIndex = 0),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_about'),
                          isActive: _activeSectionIndex == 1,
                          onTap: () => setState(() => _activeSectionIndex = 1),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_services'),
                          isActive: _activeSectionIndex == 2,
                          onTap: () => setState(() => _activeSectionIndex = 2),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_industries'),
                          isActive: _activeSectionIndex == 3,
                          onTap: () => setState(() => _activeSectionIndex = 3),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_careers'),
                          isActive: _activeSectionIndex == 4,
                          onTap: () => setState(() => _activeSectionIndex = 4),
                        ),
                        CustomNavButton(
                          text: AppLocalizations.of(
                            context,
                          )!.translate('nav_contact'),
                          isActive: _activeSectionIndex == 5,
                          onTap: () => setState(() => _activeSectionIndex = 5),
                        ),
                      ],
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            color: isDark ? Colors.amberAccent : Colors.black87,
                            size: 26,
                          ),
                          onPressed: () {
                            context.read<ThemeProvider>().toggleTheme();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                          ImageIcons().buildImageIcon(
                            "assets/images/email.PNG",
                            email,
                          ),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon(
                            "assets/images/whatsapp.PNG",
                            whatsapp,
                          ),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon(
                            "assets/images/message.PNG",
                            message,
                          ),
                          const SizedBox(height: 12),
                          ImageIcons().buildImageIcon(
                            "assets/images/call.PNG",
                            call,
                          ),
                          const SizedBox(height: 15),
                        ],
                        FloatingActionButton(
                          backgroundColor: AppColors.primaryBlue,
                          elevation: 8,
                          onPressed: () =>
                              setState(() => _isChatOpen = !_isChatOpen),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: _isChatOpen
                                ? const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    key: ValueKey("close"),
                                  )
                                : const Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.white,
                                    key: ValueKey("chat"),
                                  ),
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
      drawer: screenWidth <= 950
          ? CustomDrawerCard(
              activeIndex: _activeSectionIndex,
              onSectionSelected: (index) =>
                  setState(() => _activeSectionIndex = index),
            )
          : null,
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
            color: isDark
                ? Colors.white.withOpacity(0.04)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
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
}
