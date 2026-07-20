import 'package:flutter/material.dart';

class WebHeaderNavigation extends StatelessWidget implements PreferredSizeWidget {
  final Function(Locale) onLanguageChange;
  
  const WebHeaderNavigation({super.key, required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      title: Row(
        children: [
          // Company Logo Space
          Icon(Icons.diversity_3, color: Colors.blue[900], size: 35),
          const SizedBox(width: 10),
          Text("CREWMANPOWER", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 22)),
          
          const Spacer(),
          
          // Menu Items for Desktop Screens (Hidden on mobile web view)
          if (screenWidth > 800) ...[
            _navButton(context, "Home"),
            _navButton(context, "About Us"),
            _navButton(context, "Services"),
            _navButton(context, "Industries"),
            _navButton(context, "Careers"),
            _navButton(context, "Contact Us"),
          ],

          const SizedBox(width: 20),

          // Dropdown Language Switcher (English, Hindi, Urdu)
          PopupMenuButton<String>(
            icon: const Icon(Icons.language, color: Colors.black87),
            onSelected: (value) {
              if (value == 'en') onLanguageChange(const Locale('en'));
              if (value == 'hi') onLanguageChange(const Locale('hi'));
              if (value == 'ur') onLanguageChange(const Locale('ur'));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'en', child: Text("English")),
              const PopupMenuItem(value: 'hi', child: Text("हिंदी (Hindi)")),
              const PopupMenuItem(value: 'ur', child: Text("اردو (Urdu)")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {
          // Navigation Route paths yahan handle honge
        },
        child: Text(text, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}