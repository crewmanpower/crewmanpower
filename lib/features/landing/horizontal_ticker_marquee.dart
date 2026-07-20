

// Fixed standalone custom rendering component driving loop animation sequences safely
import 'package:flutter/material.dart';

class HorizontalTickerMarquee extends StatefulWidget {
  final List<String> items;
  const HorizontalTickerMarquee({super.key, required this.items});

  @override
  State<HorizontalTickerMarquee> createState() => _HorizontalTickerMarqueeState();
}

class _HorizontalTickerMarqueeState extends State<HorizontalTickerMarquee> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoopAnimation());
  }

  void _startLoopAnimation() {
    if (!_scrollController.hasClients) return;
    
    double maxExtent = _scrollController.position.maxScrollExtent;
    double currentPosition = _scrollController.offset;
    
    // Crucial safety check: if maxExtent is 0 or less, fallback to a healthy width constraint
    // to protect against a divide-by-zero math operation producing NaN.
    double criticalTarget = maxExtent > 0 ? maxExtent : 600.0;
    
    double executionDurationFactor = (criticalTarget - currentPosition) / criticalTarget;
    
    // If executionDurationFactor is NaN or invalid, explicitly set a default factor fallback
    if (executionDurationFactor.isNaN || executionDurationFactor.isInfinite) {
      executionDurationFactor = 1.0;
    }

    int durationSeconds = (25 * executionDurationFactor).toInt().clamp(1, 25);

    _scrollController.animateTo(
      criticalTarget,
      duration: Duration(seconds: durationSeconds),
      curve: Curves.linear,
    ).then((_) {
      if (mounted) {
        _scrollController.jumpTo(0.0);
        _startLoopAnimation();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final contentIndex = index % widget.items.length;
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            widget.items[contentIndex],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.25,
            ),
          ),
        );
      },
    );
  }
}