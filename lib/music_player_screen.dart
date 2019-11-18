import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  final String title;

  MusicPlayerScreen(this.title);

  @override
  _MusicPlayerScreen createState() => _MusicPlayerScreen();
}

class _MusicPlayerScreen extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    // TODO: implement build
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _buildWidgetAlbumCoverBlur(mediaQueryData)
          ],
    ));
  }

  Widget _buildWidgetAlbumCoverBlur(MediaQueryData mediaQueryData) {
    return Container(
      width: double.infinity,
      height: mediaQueryData.size.height / 1.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: AssetImage(
                  'assets/ariana_grande_cover_no_tears_left_to_cry.jpg'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetContainerMusicPlayer(MediaQueryData mediaQueryData){
    return Padding(
      padding: EdgeInsets.only(
        top: mediaQueryData.padding.top + 16.0),
      child: Column(
          children: <Widget>[
            
        ],),
    );
  }

  Widget _buildWidgetActionAppBar(){
    return Padding(
      padding : const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white
            ),
          ),
          Text(
            'Artist',
            style: ,
          ),
          Icon(

          )
        ],
      ),
    )
  }

}
