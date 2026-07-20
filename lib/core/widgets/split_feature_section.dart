import 'package:flutter/material.dart';

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
    // Read brightness mode and color definitions directly from the system theme context
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Fall back gracefully if primaryColor is close to custom background colors
    final themeColor = theme.primaryColor;

    // Adaptive backgrounds based on theme brightness and row order
    final sectionBgColor = isDark 
        ? (imageRight ? theme.scaffoldBackgroundColor : theme.cardColor)
        : (imageRight ? Colors.white : const Color(0xFFF8FAFC));

    final cardBgColor = isDark ? theme.cardColor : Colors.white;
    final fallbackBgColor = isDark ? Colors.grey[900]! : const Color(0xFFF1F5F9);

    // Text Style definitions mapping theme schemes dynamically
    final titleTextColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final descTextColor = isDark ? Colors.white70 : Colors.black54;
    final blueprintSubText = isDark ? Colors.white38 : Colors.black38;

    // Dynamic text content block layout
    Widget textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, 
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              color: themeColor, 
              fontSize: 15, 
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

    // Premium Dynamic Layout Block that accommodates images and fills container sizes
    Widget showcaseGraphicBlock = Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isDesktop ? 0 : 320), 
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: themeColor.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: fallbackBgColor,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined, 
                      size: 48, 
                      color: themeColor.withOpacity(0.4),
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
                      color: themeColor.withOpacity(0.04),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          themeColor.withOpacity(0.03), 
                          themeColor.withOpacity(0.07),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(mockupIcon, size: 56, color: themeColor),
                        const SizedBox(height: 14),
                        Text(
                          "Interactive Interface Blueprint",
                          style: TextStyle(
                            color: themeColor, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Production System Module Active", 
                          style: TextStyle(
                            color: blueprintSubText, 
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
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: isDesktop ? 60 : 24),
      color: sectionBgColor,
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