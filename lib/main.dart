import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<YoutubePlayerController> _controllers;
  AudioPlayer audioPlayer = AudioPlayer();
  String? currentlyPlaying;

  @override
  void initState() {
    super.initState();
    List<String> videoUrls = [
      "https://youtu.be/NtNYwMSpIBg",
      "https://youtu.be/ICTdbvHWCOA",
      "https://youtu.be/eZZR2YQoVyg",
      "https://youtu.be/Fllc8mUtZUc",
      "https://youtu.be/ef3kenC4xa0",
    ];

    _controllers =
        videoUrls.map((url) {
          String? videoId = YoutubePlayer.convertUrlToId(url);
          return YoutubePlayerController(
            initialVideoId: videoId!,
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }).toList();
  }

  void playAudio(String audioFile) async {
    if (currentlyPlaying == audioFile) {
      await audioPlayer.stop();
      setState(() {
        currentlyPlaying = null;
      });
    } else {
      await audioPlayer.play(AssetSource(audioFile));
      setState(() {
        currentlyPlaying = audioFile;
      });
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    audioPlayer.dispose();
    super.dispose();
  }

  // Profile Screen Widget (index 0)
  Widget _buildProfileScreen() {
    List<String> images = [
      'assets/images/image1.jpg',
      'assets/images/images2.jpg',
      'assets/images/images3.jpg',
      'assets/images/images4.jpg',
      'assets/images/images5.jpg',
    ];

    return Column(
      children: [
        Container(
          color: Colors.pink,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'MY PROFILE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          child: Icon(Icons.person, size: 50, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20),
        Text(
          'Lloyd Aaron Ryel Capili',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          'BSIT - II',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(images[index], fit: BoxFit.cover),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Video Screen Widget (index 1)
  // Video Screen Widget (index 1)
  Widget _buildVideoScreen() {
    List<String> videoTitles = [
      "Timeless | Spider-Verse",
      "NEW UPDATED TIER LIST for PATCH 25.4 - League of Legends",
      "Metro Boomin - Heroes & Villains [Album Mix prod. by SBDAgain]",
      "22Gz - Twirlanta ( slowed & reverb ) + Best loop END OF WATCH",
      "Java - Simple setup for hashing algorithms: MD5, SHA-1 and SHA-265.",
    ];

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.pinkAccent),
          child: Center(
            child: Text(
              "MY VIDEO'S",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Video List
        Expanded(
          child: ListView.builder(
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Video Player
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: YoutubePlayer(
                        controller: _controllers[index],
                        showVideoProgressIndicator: true,
                      ),
                    ),
                    // Video Title Below
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        videoTitles[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Audio Screen Widget (index 2)
  Widget _buildAudioScreen() {
    List<Map<String, String>> audioTracks = [
      {
        "title": "Most Wanted",
        "duration": "1:36",
        "file": "assets/audios/audio1.mp3",
      },
      {
        "title": "Make It To The Morning",
        "duration": "2:48",
        "file": "assets/audios/audio2.mp3",
      },
      {
        "title": "Like Him (feat. Lola Young)",
        "duration": "2:48",
        "file": "assets/audios/audio2.mp3",
      },
      {
        "title": "Make It To The Morning",
        "duration": "2:48",
        "file": "assets/audios/audio2.mp3",
      },
      {
        "title": "Make It To The Morning",
        "duration": "2:48",
        "file": "assets/audios/audio2.mp3",
      },
    ];

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          decoration: BoxDecoration(color: Colors.pinkAccent),
          child: Center(
            child: Text(
              "MY AUDIO'S",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Audio List
        Expanded(
          child: ListView.builder(
            itemCount: audioTracks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.height * 0.015,
                    ),
                    onTap: () {
                      playAudio(audioTracks[index]["file"]!);
                    },
                    leading: Icon(
                      currentlyPlaying == audioTracks[index]["file"]
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.pinkAccent,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                    title: Text(
                      audioTracks[index]["title"]!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      audioTracks[index]["duration"]!,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _selectedIndex == 0
              ? _buildProfileScreen()
              : _selectedIndex == 1
              ? _buildVideoScreen()
              : _buildAudioScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: ''),
        ],
      ),
    );
  }
}
