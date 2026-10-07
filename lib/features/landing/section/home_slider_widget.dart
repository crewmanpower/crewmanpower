import 'dart:async';

import 'package:crewmanpower/core/model/cms_model.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';
import 'package:crewmanpower/core/service/cms_service.dart';
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  final bool isDesktop;
  final bool isDark;
  final VoidCallback? onReadMore;
  final VoidCallback? onContact;

  const HomeSliderWidget({
    super.key,
    required this.isDesktop,
    required this.isDark,
    this.onReadMore,
    this.onContact,
  });

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  StreamSubscription<List<CmsModel>>? _sliderSubscription;
  List<CmsModel> _sliderList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _sliderSubscription = CmsService()
        .getSectionData('home_slider')
        .listen(
          (list) {
            if (!mounted) return;
            setState(() {
              _sliderList = list;
              _currentIndex = 0;
              _isLoading = false;
            });
            _startAutoScroll();
            if (_pageController.hasClients) {
              _pageController.jumpToPage(0);
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            debugPrint('Unable to load home slider content: $error');
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
            _startAutoScroll();
          },
        );
  }

  void _startAutoScroll() {
    _timer?.cancel();
    if (_sliderList.length < 2) return;

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients || _sliderList.length < 2) return;
      final nextIndex = (_currentIndex + 1) % _sliderList.length;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _sliderSubscription?.cancel();
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 440,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final isDark = widget.isDark;
    final activeColors = isDark ? AppColors.dark : AppColors.light;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = widget.isDesktop && width > 900;
    final slides = _sliderList;
    final itemCount = slides.isEmpty ? 1 : slides.length;
    final heroHeight = isWide ? 470.0 : 680.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(isWide ? 44 : 16, 18, isWide ? 44 : 16, 12),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: Container(
            height: heroHeight,
            decoration: BoxDecoration(
              color: activeColors.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: activeColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.28 : 0.09),
                  blurRadius: 32,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: itemCount,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      final item = slides.isEmpty ? null : slides[index];
                      return _buildSlide(
                        item: item,
                        isWide: isWide,
                        activeColors: activeColors,
                        isDark: isDark,
                      );
                    },
                  ),
                  if (itemCount > 1)
                    Positioned(
                      right: isWide ? 28 : 0,
                      bottom: isWide ? 25 : 18,
                      left: isWide ? null : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          itemCount,
                          (index) => Semantics(
                            label: 'Slide ${index + 1} of $itemCount',
                            button: true,
                            child: InkWell(
                              onTap: () => _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: _currentIndex == index ? 26 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? AppColors.primaryBlue
                                        : (isWide
                                              ? activeColors.textSecondary
                                                    .withOpacity(0.35)
                                              : Colors.white.withOpacity(0.65)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
Widget _buildSlide({
    required CmsModel? item,
    required bool isWide,
    required BaseThemeColors activeColors,
    required bool isDark,
  }) {
    final title = item?.title.isNotEmpty == true
        ? item!.title
        : 'The right people.\nThe right way.';
    final subtitle = item?.subtitle.isNotEmpty == true
        ? item!.subtitle
        : 'PEOPLE FIRST. PROGRESS ALWAYS.';
    final description = item?.description.isNotEmpty == true
        ? item!.description
        : 'Reliable workforce solutions that help businesses and people grow together.';
    final imageUrl = item?.imageUrl ?? '';

    final content = Padding(
      padding: EdgeInsets.fromLTRB(
        isWide ? 56 : 26,
        isWide ? 48 : 30,
        isWide ? 40 : 26,
        isWide ? 48 : 54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(isDark ? 0.22 : 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              subtitle.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: activeColors.textPrimary,
              fontSize: isWide ? 42 : 29,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: -1.1,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: activeColors.textSecondary,
                fontSize: isWide ? 16 : 15,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              FilledButton(
                onPressed: widget.onReadMore,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Read More'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 17),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: widget.onContact,
                style: OutlinedButton.styleFrom(
                  foregroundColor: activeColors.textPrimary,
                  side: BorderSide(color: activeColors.border),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Contact Us'),
              ),
            ],
          ),
        ],
      ),
    );

    if (!isWide) {
      return Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildVisual(imageUrl, isDark, isWide: false),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              color: activeColors.surface,
              child: SingleChildScrollView(child: content),
            ),
          ),
        ],
      );
    }

    // Yahan order fix kiya hai: Pehle background image poore area mein, phir uske upar white curved panel
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: _buildVisual(imageUrl, isDark, isWide: true)),
        ClipPath(
          clipper: _HeroPanelClipper(),
          child: ColoredBox(
            color: activeColors.surface,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width > 1250
                    ? 720
                    : MediaQuery.sizeOf(context).width * 0.62,
                child: content,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildVisual(String imageUrl, bool isDark, {required bool isWide}) {
    final placeholder = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF123267), Color(0xFF071426)]
              : const [Color(0xFF174A9C), Color(0xFF071D43)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: isWide ? 75 : 24,
            top: 35,
            child: Icon(
              Icons.groups_rounded,
              size: isWide ? 230 : 130,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
        ],
      ),
    );

    if (imageUrl.isEmpty) return placeholder;

    // Image ko BoxFit.cover diya gaya hai taki image poori tarah expand ho aur choti na dikhe
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Unable to load home slider image: $error');
        return placeholder;
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Stack(
          fit: StackFit.expand,
          children: [
            placeholder,
            Center(
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
class _HeroPanelClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0) // Top-left corner se start
      ..lineTo(size.width * 0.15, 0) // Top edge thoda aage tak seedha
      ..quadraticBezierTo(
        size.width * 0.55, size.height * 0.15, // Control point jo curve ko upar ki taraf rakhega
        size.width * 0.72, size.height,        // Bottom par end point (approx 72% width par)
      )
      ..lineTo(0, size.height) // Niche se left corner tak
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}