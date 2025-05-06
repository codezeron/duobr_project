import 'package:flutter/material.dart';

class SwipeFeedback extends StatelessWidget {
  final ValueNotifier<String?> feedbackNotifier;

  const SwipeFeedback({super.key, required this.feedbackNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: feedbackNotifier,
      builder: (_, value, __) {
        return Positioned(
          top: 100,
          child: AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: value != null ? 100 : -100,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: AnimatedOpacity(
              opacity: value != null ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child:
                  value != null
                      ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                        child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      )
                      : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
