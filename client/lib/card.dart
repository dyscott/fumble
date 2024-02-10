import 'package:flutter/material.dart';

class ExpandableBioCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String bio;

  const ExpandableBioCard({super.key, 
    required this.avatarUrl,
    required this.name,
    required this.bio,
  });

  @override
  _ExpandableBioCardState createState() => _ExpandableBioCardState();
}

class _ExpandableBioCardState extends State<ExpandableBioCard> {
  bool _expandBio = false;

  @override
  @override
Widget build(BuildContext context) {
  return Stack(
    children: [
      Image.network(
        widget.avatarUrl,
        height: 550,
        width: double.infinity,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter, // Align the image to the top
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expandBio = !_expandBio;
                  });
                },
                child: Text(
                  _expandBio ? widget.bio : '${widget.bio.substring(0, 50)}...',
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: ExpandableBioCard(
//         avatarUrl: 'https://example.com/avatar.png',
//         name: 'Gretta',
//         bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//       ),
//     ),
//   ));
// }
