import 'package:crewmanpower/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'marketing_provider.dart';

class MarketingWebView extends StatelessWidget {
  const MarketingWebView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) {
        final p = MarketingProvider();
        p.loadData();
        return p;
      },
      child: Builder(
        builder: (ctx) {
          final provider = ctx.watch<MarketingProvider>();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth > 1100 ? screenWidth * 0.15 : 20,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- TESTIMONIALS SECTION ---
                Text(
                  AppLocalizations.of(context)!.translate('testimonials_title'),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                screenWidth > 800
                    ? Row(
                        children: provider.testimonials
                            .map(
                              (t) => Expanded(
                                child: TestimonialCard(
                                  client: t['client'] ?? '',
                                  review: t['review'] ?? '',
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: provider.testimonials
                            .map(
                              (t) => TestimonialCard(
                                client: t['client'] ?? '',
                                review: t['review'] ?? '',
                              ),
                            )
                            .toList(),
                      ),

                const SizedBox(height: 50),

                // --- FAQ SECTION ---
                Text(
                  AppLocalizations.of(context)!.translate('faq_title'),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                ...provider.faqs
                    .map(
                      (f) => ExpansionTile(
                        title: Text(
                          f['q'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(f['a'] ?? ''),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String client;
  final String review;

  const TestimonialCard({Key? key, required this.client, required this.review})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review, style: const TextStyle(fontSize: 14, height: 1.4)),
            const SizedBox(height: 12),
            Text(
              '- $client',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
