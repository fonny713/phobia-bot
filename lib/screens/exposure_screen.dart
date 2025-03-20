import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';


class ExposureScreen extends StatefulWidget {
  final int difficulty; // 1-5
  final int initialLevel; // 1-5

  const ExposureScreen({Key? key, required this.difficulty, required this.initialLevel}) : super(key: key);

  @override
  State<ExposureScreen> createState() => _ExposureScreenState();
}

class _ExposureScreenState extends State<ExposureScreen> {
  late int _currentLevel;
  late ConfettiController _confettiController;


  @override
  void initState() {
    super.initState();
    _currentLevel = widget.initialLevel;
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

  }

  final Map<int, Map<int, Map<String, String>>> _levelData = {
    1: {
      1: {
        'image': 'assets/images/cartoon_spider.jpg',
        'fact': 'Pająki mają od 4 do 8 oczu, ale wiele z nich widzi bardzo słabo.',
      },
      2: {
        'image': 'assets/images/cartoon_spider2.jpg',
        'fact': 'Pajęczyna pająka jest mocniejsza od stali o tej samej grubości.',
      },
      3: {
        'image': 'assets/images/cartoon_spider3.jpg',
        'fact': 'Niektóre pająki potrafią unosić się na wietrze, używając nici pajęczej.',
      },
      4: {
        'image': 'assets/images/small_spider.jpg',
        'fact': 'Większość pająków nie stanowi zagrożenia dla ludzi.',
      },
      5: {
        'image': 'assets/images/cartoon_spider_5.jpg',
        'fact': 'Pająki pomagają kontrolować populacje owadów w naszych domach i ogrodach.',
      },
    },
    2: {
      1: {
        'image': 'assets/images/real_spider_1.jpg',
        'fact': 'Niektóre pająki potrafią przetrwać wiele dni bez jedzenia.',
      },
      2: {
        'image': 'assets/images/real_spider_2.jpg',
        'fact': 'Pająki linieją, czyli zrzucają zewnętrzny pancerz, gdy rosną.',
      },
      3: {
        'image': 'assets/images/real_spider_3.jpg',
        'fact': 'Samice niektórych gatunków są znacznie większe od samców.',
      },
      4: {
        'image': 'assets/images/real_spider_4.jpg',
        'fact': 'Pająki są ważnym ogniwem w łańcuchu pokarmowym.',
      },
      5: {
        'image': 'assets/images/real_spider_5.jpg',
        'fact': 'Ich jad zwykle działa tylko na owady.',
      },
    },
    // Dodaj poziomy trudności 3, 4, 5 tutaj
  };

  void _nextLevel() {
    if (_currentLevel < 5) {
      setState(() => _currentLevel++);
      if (_currentLevel == 5) {
        Future.delayed(const Duration(milliseconds: 400), () {
          _showCompletionDialog();
        });
      }
    }
  }

  void _previousLevel() {
    if (_currentLevel > 1) {
      setState(() => _currentLevel--);
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber, size: 60),
              const SizedBox(height: 16),
              const Text(
                "Gratulacje!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Ukończyłeś wszystkie poziomy w tym trybie ekspozycji.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(); // zamknij dialog
                      setState(() {
                        _currentLevel = 1; // zresetuj poziom
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Od nowa"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(); // zamknij dialog
                      Navigator.of(context).pop(); // wróć do menu
                    },
                    icon: const Icon(Icons.home),
                    label: const Text("Menu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final image = _levelData[widget.difficulty]?[_currentLevel]?['image'] ?? '';
    final fact = _levelData[widget.difficulty]?[_currentLevel]?['fact'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Ekspozycja - Trudność ${widget.difficulty}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            "Poziom $_currentLevel",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Ukończono ${(100 * (_currentLevel / 5)).round()}%",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: _currentLevel / 5,
                  ),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
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
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..value = 1.0;

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _onTapDown(_) => _controller.reverse();
  void _onTapUp(_) => _controller.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: (_) => _onTapUp(null),
      onTapCancel: () => _onTapUp(null),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF8AA8FF),
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
    _confettiController.dispose();
    super.dispose();
  }
}
