import 'package:basic_flutter/music_player_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF7D9AFF),
          accentColor: Color(0xFF7D9AFF),
        ),
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> listSong = List();

  @override
  void initState() {
    initListSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        key: scaffoldState,
        body: Stack(
          children: <Widget>[
            _buildWidgetAlbumCover(mediaQueryData),
            _buildWidgetActionAppBar(mediaQueryData),
            _buildWidgetArtistName(mediaQueryData),
            _buildWidgetFloatingButton(mediaQueryData),
            _buildWidgetListSong(mediaQueryData)
          ],
        ));
  }

  Widget _buildWidgetAlbumCover(MediaQueryData mediaQueryData) {
    return Container(
      width: double.infinity,
      height: mediaQueryData.size.height / 1.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(48.0)),
          image: DecorationImage(
              image: AssetImage(
                  'assets/ariana_grande_cover_no_tears_left_to_cry.jpg'),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildWidgetActionAppBar(MediaQueryData mediaQueryData) {
    return Padding(
      padding: EdgeInsets.only(
          left: 17.0, top: mediaQueryData.padding.top + 17.0, right: 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetArtistName(MediaQueryData mediaQueryData) {
    return SizedBox(
      height: mediaQueryData.size.height / 1.8,
      child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: <Widget>[
                  Positioned(
                    child: Text('Grande',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CoralPen',
                            fontSize: 72.0)),
                    top: constraints.maxHeight - 100.0,
                  ),
                  Positioned(
                    child: Text('Ariana',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CoralPen',
                            fontSize: 72.0)),
                    top: constraints.maxHeight - 140.0,
                  ),
                  Positioned(
                    child: Text('Tranding',
                        style: TextStyle(
                            color: Color(0xFF7D9AFF),
                            fontFamily: 'Campton_Light',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800)),
                    top: constraints.maxHeight - 160.0,
                  )
                ],
              );
            },
          )),
    );
  }

  Widget _buildWidgetFloatingButton(MediaQueryData mediaQueryData) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
          padding: EdgeInsets.only(
            top: mediaQueryData.size.height / 1.8 - 32.0,
            right: 32.0,
          ),
          child: FloatingActionButton(
            backgroundColor: Color(0xFF7D9AFF),
            onPressed: () {
              _navigatorToMusicPlayerScreen(listSong[0].title);
            },
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          )),
    );
  }

  Widget _buildWidgetListSong(MediaQueryData mediaQueryData) {
    return Padding(
        padding: EdgeInsets.only(
            left: 20.0,
            top: mediaQueryData.size.height / 1.8 + 32.0,
            right: 20.0,
            bottom: mediaQueryData.padding.bottom + 16.0),
        child: Column(
          children: <Widget>[
            _buildWidgetHeaderSong(),
            SizedBox(height: 14.0),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  Song song = listSong[index];
                  return GestureDetector(
                    onTap: () {
                      _navigatorToMusicPlayerScreen(song.title);
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(song.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Campton_Light'),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          song.duration,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Opacity(
                    opacity: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                itemCount: listSong.length,
              ),
            )
          ],
        ));
  }

  Widget _buildWidgetHeaderSong() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Popular',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            fontFamily: 'Campton_Light',
          ),
        ),
        Text(
          'Show All',
          style: TextStyle(
            color: Color(0xFF7D9AFF),
            fontWeight: FontWeight.w600,
            fontFamily: 'Campton_Light',
          ),
        )
      ],
    );
  }

  void _navigatorToMusicPlayerScreen(String title){
    Navigator.of(scaffoldState.currentContext).push(MaterialPageRoute(builder: (context){
      return MusicPlayerScreen(title);
    }));
  }

  void initListSong() {
    listSong.add(Song(title: 'No tears left to cry', duration: '5:20'));
    listSong.add(Song(title: 'Imagine', duration: '3:20'));
    listSong.add(Song(title: 'Into you', duration: '4:12'));
    listSong.add(Song(title: 'One last time', duration: '4:40'));
    listSong.add(Song(title: '7 rings', duration: '2:58'));
    listSong.add(Song(title: 'Thank u, next', duration: '3:27'));
    listSong.add(Song(
        title: 'Break up with your girlfriend, i\'m bored', duration: '3:10'));
  }
}

// List Song

class Song {
  String title;
  String duration;

  Song({this.title, this.duration});

  @override
  String toString() {
    return 'Song {title : $title, duration: $duration}';
  }
}
