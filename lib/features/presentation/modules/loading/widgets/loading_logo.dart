import 'package:flutter/material.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 423,
      height: 932,
      padding: const EdgeInsets.only(
        top: 260,
        left: 89,
        right: 88,
        bottom: 347,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 246,
            height: 325,
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  top: 264,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Learn',
                          style: TextStyle(
                            color: Color(0xFF215273),
                            fontSize: 49,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        TextSpan(
                          text: '2',
                          style: TextStyle(
                            color: Color(0xFF55C595),
                            fontSize: 49,
                            fontFamily: 'Lexend',
                          ),
                        ),
                        TextSpan(
                          text: 'Aid',
                          style: TextStyle(
                            color: Color(0xFF215273),
                            fontSize: 49,
                            fontFamily: 'Lexend',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 79,
                  top: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0 ? const Color(0xFF215273) : null,
                            border: index != 0
                                ? Border.all(width: 2, color: Colors.black)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
