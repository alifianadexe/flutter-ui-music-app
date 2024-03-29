import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class MusicPlayerScreen extends StatefulWidget {
  final String title;

  MusicPlayerScreen(this.title);

  @override
  _MusicPlayerScreen createState() => _MusicPlayerScreen();
}

class _MusicPlayerScreen extends State<MusicPlayerScreen> {
  double _sliderDurationMusic = 50.0;
  double _sliderVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    // TODO: implement build
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _buildWidgetAlbumCoverBlur(mediaQueryData),
            _buildWidgetContainerMusicPlayer(mediaQueryData)
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
            _buildWidgetActionAppBar(mediaQueryData),
            SizedBox(height: 48.0,),
            _buildWidgetPanelMusicPlayer(mediaQueryData)
        ],),
    );
  }

  Widget _buildWidgetActionAppBar(MediaQueryData mediaQueryData){
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
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Campton_Light',
              fontWeight: FontWeight.w600,
              fontSize: 16.0
            ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _buildWidgetPanelMusicPlayer(MediaQueryData mediaQueryData){
    return Expanded(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48.0),
              topRight: Radius.circular(48.0)            
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 36.0,),
                _buildWidgetArtistPhoto(mediaQueryData),
                SizedBox(height: 48.0,),
                _buildWidgetLinearProgressIndicator(),
                SizedBox(height: 2.0,),
                _buildWidgetLabelDurationMusic(),
                _buildWidgetMusicInfo(),
                _buildWidgetControlMusicPlayer(),
                _buildWidgetControlVolume()
            ],),
          ),
      ),
    );
  }

  Widget _buildWidgetArtistPhoto(MediaQueryData mediaQueryData){
    return Center(
      child: Container(
        width: mediaQueryData.size.width / 2.5,
        height: mediaQueryData.size.width / 2.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(24.0)
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/ariana_grande_artist_photo_3.png",
            ),
            fit: BoxFit.cover
            ),
        ),
      ),
    );
  }

  Widget _buildWidgetLinearProgressIndicator(){
    return SizedBox(
      height: 2.0,
      child: LinearProgressIndicator(
        value: 0.3,
        valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xFF7D9AFF)
        ),
        backgroundColor: Colors.grey.withOpacity(0.2),
      )
    );
  }

  Widget _buildWidgetLabelDurationMusic(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "1:20",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0
          ),
        ),
        Text(
          "4:45",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0
          ),
        )
    ],);
  }

  Widget _buildWidgetMusicInfo(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Campton_Light",
              fontSize: 20.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.0,),
          Text(
              "Ariana Grande",
              style: TextStyle(
                fontFamily: "Campton_Light",
                color: Color(0xFF7D9AFF),
                fontWeight: FontWeight.w600
              ),
          ),
        ],),
    );
  }

  Widget _buildWidgetControlMusicPlayer(){
    return Expanded(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Icon(Icons.fast_rewind),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Icon(Icons.pause),
              ),
            ),
            Expanded(
              child: Icon(Icons.fast_forward),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetControlVolume(){
    return Expanded(
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.volume_mute,
              color: Colors.grey.withOpacity(0.5),
            ),
            Expanded(
              child: Slider(
                min:0.0,
                max: 1.0,
                value: _sliderVolume,
                activeColor: Colors.black,
                inactiveColor: Colors.grey.withOpacity(0.5),
                onChanged: (value){
                  setState(() =>  _sliderVolume = value);
                },
              ),
            ),
            Icon(
              Icons.volume_up,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }



}
