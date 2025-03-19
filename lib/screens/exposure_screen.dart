import 'package:flutter/material.dart';

class ExposureScreen extends StatefulWidget {
  const ExposureScreen({Key? key}) : super(key: key);

  @override
  State<ExposureScreen> createState() => _ExposureScreenState();
}

class _AnimatedGlassButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  const _AnimatedGlassButton({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  State<_AnimatedGlassButton> createState() => _AnimatedGlassButtonState();
}

class _AnimatedGlassButtonState extends State<_AnimatedGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  void _onTapDown(_) => _controller.forward();
  void _onTapUp(_) => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _controller.reverse,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Color(0xFF8AA8FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


class _ExposureScreenState extends State<ExposureScreen> {
  int _currentLevel = 1;

  final List<String> _imagePaths = [
    'assets/images/cartoon_spider.jpg',
    'assets/images/cartoon_spider2.jpg',
    'assets/images/cartoon_spider3.jpg',
    'assets/images/small_spider.jpg',
    'assets/images/cartoon_spider_5.jpg',
  ];

  final List<String> _facts = [
    "Pająki mają od 4 do 8 oczu, ale wiele z nich widzi bardzo słabo.",
    "Pajęczyna pająka jest mocniejsza od stali o tej samej grubości.",
    "Niektóre pająki potrafią unosić się na wietrze, używając nici pajęczej.",
    "Większość pająków nie stanowi zagrożenia dla ludzi.",
    "Pająki pomagają kontrolować populacje owadów w naszych domach i ogrodach.",
  ];

  void _nextLevel() {
    if (_currentLevel < _imagePaths.length) {
      setState(() {
        _currentLevel++;
      });
    }
  }

  void _previousLevel() {
    if (_currentLevel > 1) {
      setState(() {
        _currentLevel--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _imagePaths[_currentLevel - 1];
    final fact = _facts[_currentLevel - 1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ekspozycja"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Poziom $_currentLevel",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.3, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey(image),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0.2, 0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Container(
              key: ValueKey(fact),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                fact,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AnimatedGlassButton(
                onTap: _previousLevel,
                label: "Poprzedni poziom",
                icon: Icons.arrow_back,
              ),
              _AnimatedGlassButton(
                onTap: _nextLevel,
                label: "Następny poziom",
                icon: Icons.arrow_forward,
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
