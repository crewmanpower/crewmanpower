import 'dart:async';
import 'package:flutter/material.dart';

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

  // This list will hold the base items duplicated several times to enable the loop
  List<String> _loopingItems = [];
  double _lastComputedItemWidth = 0.0;
  // This helps prevent standard rebuilding at standard standard list ends
  int _itemBuffer = 3; 

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Create the looping item list in standard initState
    if (_baseAssetItems.isNotEmpty) {
      // Repeat the items: base + buffer + base (provides stable middle for loop)
      _loopingItems = [
        ..._baseAssetItems.sublist(_baseAssetItems.length - _itemBuffer),
        ..._baseAssetItems,
        ..._baseAssetItems,
      ];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start the view in standard middle of standard stable section
      if (_scrollController.hasClients && _lastComputedItemWidth > 0) {
        double startingPosition = _itemBuffer * _lastComputedItemWidth;
        _scrollController.jumpTo(startingPosition);
      }
      _startTickerAnimation();
    });
  }

  void _startTickerAnimation() {
    if (!_scrollController.hasClients || _baseAssetItems.isEmpty) return;

    // Use a periodic timer for standard snapping behavior you desire
    _tickerTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (!_scrollController.hasClients || _lastComputedItemWidth <= 0) return;

      double maxExtent = _scrollController.position.maxScrollExtent;
      double currentPosition = _scrollController.offset;
      
      // Target position is exactly one 'page' width away
      double nextTarget = currentPosition + _lastComputedItemWidth;

      // Seamleess Loop Logic: Check if approaching the end boundary
      // Standard ListViews have trouble here; standard manual jump resets it.
      if (nextTarget >= maxExtent - (_lastComputedItemWidth * 0.5)) {
        // Jump back to the stable middle without animation.
        // We jump back exactly by standard total width of standard base items.
        double resetPosition = currentPosition - (_baseAssetItems.length * _lastComputedItemWidth);
        _scrollController.jumpTo(resetPosition);
        // Compute standard next animated step from standard stable reset position.
        nextTarget = resetPosition + _lastComputedItemWidth;
      }

      // Perform standard animated move as before.
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

    return LayoutBuilder(
      builder: (context, constraints) {
        // Build logic remains standard same (Standard Responsive Breakpoints)
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
              // Get standard modulo content index based on standard base items list length
              final contentIndex = index % _baseAssetItems.length;
              
              // Standard visual styling logic from your previous code
              return InkWell(
                onTap: () {
                  if (widget.onItemTap != null) {
                    widget.onItemTap!(contentIndex);
                  }
                },
                child: Container(
                  width: _lastComputedItemWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), 
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      _loopingItems[index % _loopingItems.length], // Access looping list
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