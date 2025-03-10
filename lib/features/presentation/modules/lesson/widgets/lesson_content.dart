import 'package:flutter/material.dart';
import 'package:learn2aid/features/presentation/global_widgets/play_button.dart';

class LessonContent extends StatelessWidget {
  const LessonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, 
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.55, 
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: progressIndicator(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Nullam tristique eros nec diam consectetur gravida. Nulla facilisi. '
                  'Vestibulum malesuada nisl tortor, tincidunt pulvinar massa lacinia ut.',
                  style: TextStyle(fontSize: 14, fontFamily: 'Nunito Sans'),
                ),
              ),
            ),
            Center(child: PlayButton()),
          ],
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              value: 0.6,
              strokeWidth: 4,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          ),
          const Text(
            '%',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
