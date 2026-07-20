import 'package:flutter/material.dart';
import 'package:crewmanpower/core/localization/app_localizations.dart';

class CustomDrawerCard extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onSectionSelected;

  const CustomDrawerCard({
    super.key,
    required this.activeIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              // ================= Header =================
              Container(
                height: 130,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logoh.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                     
                      
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ================= Menu =================
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildModernMenuTile(
                      context,
                      Icons.home_rounded,
                      'nav_home',
                      0,
                    ),
                    _buildModernMenuTile(
                      context,
                      Icons.info_outline_rounded,
                      'nav_about',
                      1,
                    ),
                    _buildModernMenuTile(
                      context,
                      Icons.layers_outlined,
                      'nav_services',
                      2,
                    ),
                    _buildModernMenuTile(
                      context,
                      Icons.domain_rounded,
                      'nav_industries',
                      3,
                    ),
                    _buildModernMenuTile(
                      context,
                      Icons.work_outline_rounded,
                      'nav_careers',
                      4,
                    ),
                    _buildModernMenuTile(
                      context,
                      Icons.quick_contacts_mail_rounded,
                      'nav_contact',
                      5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernMenuTile(
    BuildContext context,
    IconData icon,
    String translationKey,
    int index,
  ) {
    final bool isSelected = activeIndex == index;
    final Color primaryColor = Colors.blue.shade900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        leading: Icon(
          icon,
          color: isSelected ? primaryColor : Colors.grey.shade700,
          size: 24,
        ),
        title: Text(
          AppLocalizations.of(context)!.translate(translationKey),
          style: TextStyle(
            fontSize: 15,
            fontWeight:
                isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? primaryColor : Colors.black87,
          ),
        ),
        selected: isSelected,
        selectedTileColor: primaryColor.withOpacity(0.08),
        onTap: () {
          onSectionSelected(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}