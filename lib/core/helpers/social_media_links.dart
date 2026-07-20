import 'package:crewmanpower/core/helpers/web_footer.dart';
import 'package:crewmanpower/core/widgets/build_image_icon.dart';
import 'package:flutter/material.dart';

class SocialMediaLinksColumn extends StatelessWidget {
  const SocialMediaLinksColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Connect With Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ImageIcons().buildImageIcon(
              "assets/images/linkdink.PNG",
              () => launchTargetUrl("https://www.linkedin.com/company/crewmanpower/"),
            ),
            // ImageIcons().buildImageIcon(
            //   "assets/images/twitter.PNG",
            //   () => launchTargetUrl("https://www.twitter.com/crewmanpower"),
            // ),
            ImageIcons().buildImageIcon(
              "assets/images/facebook.PNG",
              () => launchTargetUrl("https://www.facebook.com/share/1EatzT5nY1/?mibextid=wwXIfr"),
            ),
            
            // ImageIcons().buildImageIcon(
            //   "assets/images/youtube.PNG",
            //   () => launchTargetUrl("YOUR_YOUTUBE_CHANNEL_LINK"),
            // ),
            
            ImageIcons().buildImageIcon(
              "assets/images/insta.PNG",
              () => launchTargetUrl("https://www.instagram.com/crewmanpower?igsh=bmRodnh5ZWtlanhs&utm_source=qr"),
            ),
          ],
        ),
      ],
    );
  }
}