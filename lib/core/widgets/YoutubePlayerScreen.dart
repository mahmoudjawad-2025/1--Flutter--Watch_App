import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;
  final String channelTitle;
  final String channelDescription;
  final String channelSubscribers;
  final String publishedDate;
  final String videoTitle;

  YoutubePlayerScreen({
    required this.videoId,
    required this.channelTitle,
    required this.channelDescription,
    required this.channelSubscribers,
    required this.publishedDate,
    required this.videoTitle,
  });

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subscribers = double.parse(widget.channelSubscribers);
    return Scaffold(
      // app bar
      appBar: AppBar(title: Text('YouTube Video')),
      // body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            onReady: () {
              print("Player is ready.");
            },
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Title and Published Date
                Container(
                  width: double.infinity,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.videoTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${widget.publishedDate}',
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 131, 128, 128)),
                      ),
                    )
                  ]),
                ),
                SizedBox(height: 8),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 2,
                  endIndent: 2,
                ),
                SizedBox(height: 8),
                // Channel Name and Subscribers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.channelTitle,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          subscribers > 1000000
                              ? 'Subscribers: ${subscribers / 1000000}M'
                              : subscribers > 1000
                                  ? "Subscribers: ${subscribers / 1000}k"
                                  : "Subscribers: ${subscribers}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 2,
                  endIndent: 2,
                ),

                // Channel Description
                Text(
                  widget.channelDescription,
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 74, 74, 74)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
