import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../util/auth.dart';
import '../../components/card.dart';
import '../home.dart';

class CardUser {
  final String name;
  final String avatarUrl;
  final String bio;
  final String id;

  CardUser(
      {required this.name,
      required this.avatarUrl,
      required this.bio,
      required this.id});
}

// Widget responsible for loading possible matches
class SwipeListPage extends StatefulWidget {
  const SwipeListPage({Key? key}) : super(key: key);

  @override
  State<SwipeListPage> createState() => _SwipeListPageState();
}

class _SwipeListPageState extends State<SwipeListPage> {
  // Query wingman to get possible matches
  Future<List<CardUser>> getPossibleMatches() async {
    var res = await pb.send('api/fumble/wingman');

    List<RecordModel> list = [];
    for (var i in res) {
      list.add(RecordModel.fromJson(i));
    }
    List<CardUser> users = [];
    for (var i in list) {
      final url = pb.files.getUrl(i, i.data['gallery'][0]).toString();
      users.add(
        CardUser(
            name: i.getStringValue('name'),
            avatarUrl: '$url?thumb=0x1024',
            bio: removeAllHtmlTags(i.getStringValue('bio')),
            id: i.id),
      );
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPossibleMatches(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<CardUser> users = snapshot.data as List<CardUser>;
          List<ExpandableBioCard> cards = users.map((user) {
            return ExpandableBioCard(
              avatarUrl: user.avatarUrl,
              name: user.name,
              bio: user.bio,
              id: user.id,
            );
          }).toList();
          return SwipeList(
            cards: cards,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// Widget responsible for swiping through possible matches
class SwipeList extends StatefulWidget {
  final List<ExpandableBioCard> cards;

  const SwipeList({
    super.key,
    required this.cards,
  });

  @override
  State<SwipeList> createState() => _SwipeListState();
}

class _SwipeListState extends State<SwipeList> {
  final controller = CardSwiperController();

  Future<bool> _onSwipe(int previousIndex, int? currentIndex,
      CardSwiperDirection direction) async {
    final card = widget.cards[previousIndex];
    final liked = direction == CardSwiperDirection.right;

    // Update the database with match/reject status
    try {
      // Get user and
      final String userID =
          Provider.of<AuthProvider>(context, listen: false).user!.id;
      final String targetID = card.id;

      // Update the database with match/reject status
      final body = <String, dynamic>{
        "author": userID,
        "target": targetID,
        "status": liked ? "like" : "reject"
      };
      await pb.collection('matches').create(body: body);
      return true;
    } catch (e) {
      debugPrint('Error updating database: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              const Center(
                child: Text(
                  "You're out of matches... check back later!",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              (widget.cards.isNotEmpty)
                  ? CardSwiper(
                      cardsCount: widget.cards.length,
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          widget.cards[index],
                      isLoop: false,
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                              horizontal: true, vertical: false),
                      maxAngle: 15,
                      onSwipe: _onSwipe,
                      controller: controller,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    )
                  : Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.thumb_down),
                  onPressed: () {
                    controller.swipe(CardSwiperDirection.left);
                  },
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    controller.swipe(CardSwiperDirection.right);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
