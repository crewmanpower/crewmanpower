import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchTargetUrl(String urlPath) async {
  final Uri targetUri = Uri.parse(urlPath);
  if (await canLaunchUrl(targetUri)) {
    await launchUrl(targetUri, mode: LaunchMode.externalApplication);
  }
}

Future<void> call() async {
  await launchTargetUrl("tel:+9194050047");
}

Future<void> email() async {
  await launchTargetUrl("mailto:info@crewmanpower.com");
}

Future<void> message() async {
  await launchTargetUrl("sms:+9194050047");
}

Future<void> whatsapp() async {
  await launchTargetUrl("https://wa.me/9194050047");
}

Widget buildLogo({double size = 40}) {
  return Image.asset("assets/images/logo.png",width: size,height: size,fit: BoxFit.contain);
}