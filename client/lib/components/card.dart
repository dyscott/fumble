import 'package:Fumble/util/misc.dart';
import 'package:flutter/material.dart';

class ExpandableBioCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String bio;
  final String id; // target user id

  const ExpandableBioCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.id,
  });

  @override
  State<ExpandableBioCard> createState() => _ExpandableBioCardState();
}

class _ExpandableBioCardState extends State<ExpandableBioCard> {
  bool _expandBio = false;

  @override
  Widget build(BuildContext context) {
    final bio = removeAllHtmlTags(widget.bio);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage('${widget.avatarUrl}?thumb=0x1024'),
                fit: BoxFit.fitHeight,
              ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandBio = !_expandBio;
                        });
                      },
                      child: Text(
                        _expandBio
                            ? bio
                            : '${bio.substring(0, bio.length > 50 ? 50 : bio.length)}...',
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
