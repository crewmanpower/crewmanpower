import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:crewmanpower/core/service/app_colors/app_colors.dart';

class HorizontalTickerMarquee extends StatefulWidget {
  final Function(int index)? onItemTap;

  const HorizontalTickerMarquee({
    super.key,
    this.onItemTap,
  });

  @override
  State<HorizontalTickerMarquee> createState() => _HorizontalTickerMarqueeState();
}

class _HorizontalTickerMarqueeState extends State<HorizontalTickerMarquee> {
  late ScrollController _scrollController;
  Timer? _tickerTimer;

  final List<String> _baseAssetItems = const [
    'assets/images/certifird_iso.PNG',
    'assets/images/india_mart_a.PNG',
    'assets/images/india_mart.PNG',
    'assets/images/msme.PNG',
    'assets/images/psara.PNG',
    'assets/images/roggar.PNG',
  ];

  List<String> _loopingItems = [];
  double _lastComputedItemWidth = 0.0;
  int _itemBuffer = 3;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    if (_baseAssetItems.isNotEmpty) {
      _loopingItems = [
        ..._baseAssetItems.sublist(_baseAssetItems.length - _itemBuffer),
        ..._baseAssetItems,
        ..._baseAssetItems,
      ];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && _lastComputedItemWidth > 0) {
        double startingPosition = _itemBuffer * _lastComputedItemWidth;
        _scrollController.jumpTo(startingPosition);
      }
      _startTickerAnimation();
    });
  }

  void _startTickerAnimation() {
    if (!_scrollController.hasClients || _baseAssetItems.isEmpty) return;

    _tickerTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (!_scrollController.hasClients || _lastComputedItemWidth <= 0) return;

      double maxExtent = _scrollController.position.maxScrollExtent;
      double currentPosition = _scrollController.offset;
      double nextTarget = currentPosition + _lastComputedItemWidth;

      if (nextTarget >= maxExtent - (_lastComputedItemWidth * 0.5)) {
        double resetPosition = currentPosition - (_baseAssetItems.length * _lastComputedItemWidth);
        _scrollController.jumpTo(resetPosition);
        nextTarget = resetPosition + _lastComputedItemWidth;
      }

      _scrollController.animateTo(
        nextTarget,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loopingItems.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        int itemsToShow;

        if (totalWidth >= 900) {
          itemsToShow = 3;
        } else if (totalWidth >= 600) {
          itemsToShow = 2;
        } else {
          itemsToShow = 1;
        }
        _lastComputedItemWidth = totalWidth / itemsToShow;

        return SizedBox(
          height: 180,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final contentIndex = index % _baseAssetItems.length;

              return InkWell(
                onTap: () {
                  if (widget.onItemTap != null) {
                    widget.onItemTap!(contentIndex);
                  }
                },
                child: Container(
                  width: _lastComputedItemWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.12),
                          blurRadius: 18,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      _loopingItems[index % _loopingItems.length],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey, size: 32),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}