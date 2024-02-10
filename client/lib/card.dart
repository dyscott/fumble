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
Widget build(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Stack(
      children: [
        SizedBox(
          width: 375,
          height: 550,
          child: Image.network(
            widget.avatarUrl,
            fit: BoxFit.cover,
          ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the horizontal padding as needed
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
                  SizedBox(height: 8), // Add vertical space between name and bio
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
        ),
      ],
    ),
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
