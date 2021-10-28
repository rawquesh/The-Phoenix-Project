import 'dart:io';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:on_audio_edit/on_audio_edit.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/heart.dart';
import 'package:phoenix/src/beginning/utilities/native/go_native.dart';
import 'package:phoenix/src/beginning/utilities/page_backend/albums_back.dart';
import 'package:phoenix/src/beginning/pages/ringtone/ringtone.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/song_edit.dart';
import '../../utilities/page_backend/artists_back.dart';
import 'package:phoenix/src/beginning/pages/genres/genres.dart';
import 'package:phoenix/src/beginning/pages/genres/genres_inside.dart';
import '../../utilities/page_backend/mansion_back.dart';
import 'package:phoenix/src/beginning/pages/playlist/playlist_inside.dart';
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/screenshot_UI.dart';
import 'package:share_plus/share_plus.dart';
import '../../utilities/constants.dart';

class OnHold extends StatefulWidget {
  final BuildContext classContext;
  final List<SongModel> listOfSong;
  final int index;
  final bool car;
  final double heightOfDevice;
  final double widthOfDevice;
  final String songOf;
  const OnHold(
      {Key key,
      @required this.classContext,
      @required this.listOfSong,
      @required this.index,
      @required this.car,
      @required this.heightOfDevice,
      @required this.widthOfDevice,
      @required this.songOf})
      : super(key: key);

  @override
  _OnHoldState createState() => _OnHoldState();
}

class _OnHoldState extends State<OnHold> {
  final List songMoreInfo = const [
    "Play Now",
    "Add To Queue",
    "Add To PlayList",
    "Share",
    "Set Ringtone",
    "Edit",
    "Delete"
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                    ),
                    alignment: Alignment.center,
                    width: widget.car
                        ? widget.heightOfDevice / 2
                        : widget.widthOfDevice / 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRounded),
                      child: BackdropFilter(
                        filter: glassBlur,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRounded),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.04)),
                            color: glassOpacity,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: widget.car
                                            ? widget.widthOfDevice / 12
                                            : widget.heightOfDevice / 25),
                                  ),
                                  for (int i = 0; i < songMoreInfo.length; i++)
                                    Material(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: Container(
                                          // color: Colors.black38,
                                          width: widget.car
                                              ? widget.heightOfDevice
                                              : widget.widthOfDevice,
                                          height: widget.car
                                              ? widget.widthOfDevice / 6
                                              : widget.heightOfDevice / 12.5,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () async {
                                                if (i == 0) {
                                                  if (widget.songOf ==
                                                      "album") {
                                                    // insideInAlbumSongs = [];
                                                    insideInAlbumSongs =
                                                        inAlbumSongs;
                                                  }
                                                  if (widget.songOf ==
                                                      "artist") {
                                                    // insideInArtistsSongs = [];
                                                    insideInArtistsSongs =
                                                        inArtistsSongs;
                                                  }
                                                  if (widget.songOf ==
                                                      "genre") {
                                                    // insidegenreSongs = [];
                                                    insidegenreSongs =
                                                        genreSongs;
                                                  }
                                                  await playThis(widget.index,
                                                      widget.songOf);
                                                  Navigator.pop(context);
                                                } else if (i == 1) {
                                                  if (widget.songOf == "all") {
                                                    addToQueue(
                                                        songListMediaItems[
                                                            widget.index]);
                                                  } else if (widget.songOf ==
                                                      "album") {
                                                    addToQueue(albumMediaItems[
                                                        widget.index]);
                                                  } else if (widget.songOf ==
                                                      "artist") {
                                                    addToQueue(artistMediaItems[
                                                        widget.index]);
                                                  } else if (widget.songOf ==
                                                      "genre") {
                                                    addToQueue(genreMediaItems[
                                                        widget.index]);
                                                  } else if (widget.songOf ==
                                                      "recent") {
                                                    addToQueue(
                                                        recentPlayedMediaItems[
                                                            widget.index]);
                                                  } else if (widget.songOf ==
                                                      "mostly") {
                                                    addToQueue(
                                                        alwaysPlayedMediaItems[
                                                            widget.index]);
                                                  } else if (widget.songOf ==
                                                      "never") {
                                                    addToQueue(
                                                        everPlayedLimitedMediaItems[
                                                            widget.index]);
                                                  } else if (widget.songOf ==
                                                      "playlist") {
                                                    addToQueue(
                                                        playlistMediaItems[
                                                            widget.index]);
                                                  }

                                                  Navigator.pop(context);
                                                } else if (i == 2) {
                                                  Map check = musicBox
                                                          .get('playlists') ??
                                                      {};
                                                  if (check.keys
                                                      .toList()
                                                      .isEmpty) {
                                                    Flushbar(
                                                      messageText: Text(
                                                          "Create A Playlist First.",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Futura",
                                                              color: Colors
                                                                  .white)),
                                                      icon: Icon(
                                                        Icons
                                                            .error_outline_rounded,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      // leftBarIndicatorColor:
                                                      //     Color(0xFFCB0047),
                                                    )..show(context);
                                                  } else {
                                                    Navigator.pop(context);
                                                    Expanded(
                                                      child: await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (context,
                                                                StateSetter
                                                                    setState) {
                                                              return Center(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  physics:
                                                                      BouncingScrollPhysics(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 0,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(kRounded),
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width: widget.car
                                                                              ? widget.heightOfDevice / 2
                                                                              : widget.widthOfDevice / 1.2,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(kRounded),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: glassBlur,
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(kRounded),
                                                                                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                  color: glassOpacity,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    ListView(
                                                                                      physics: BouncingScrollPhysics(),
                                                                                      shrinkWrap: true,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(top: widget.car ? widget.widthOfDevice / 12 : widget.heightOfDevice / 25),
                                                                                        ),
                                                                                        for (int o = 0; o < check.keys.toList().length; o++)
                                                                                          Material(
                                                                                            color: Colors.transparent,
                                                                                            child: Center(
                                                                                              child: SizedBox(
                                                                                                width: widget.car ? widget.heightOfDevice : widget.widthOfDevice,
                                                                                                height: widget.car ? widget.widthOfDevice / 6 : widget.heightOfDevice / 12.5,
                                                                                                child: Material(
                                                                                                  color: Colors.transparent,
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      Navigator.pop(context);
                                                                                                      if (check[check.keys.toList()[o]].contains(widget.listOfSong[widget.index].data)) {
                                                                                                        Flushbar(
                                                                                                          messageText: Text("Song Already In Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                          icon: Icon(
                                                                                                            Icons.error_outline_rounded,
                                                                                                            size: 28.0,
                                                                                                            color: Color(0xFFCB0447),
                                                                                                          ),
                                                                                                          shouldIconPulse: true,
                                                                                                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                          duration: Duration(seconds: 5),
                                                                                                          borderColor: Colors.white.withOpacity(0.04),
                                                                                                          borderWidth: 1,
                                                                                                          backgroundColor: glassOpacity,
                                                                                                          flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                          isDismissible: true,
                                                                                                          barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                          margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                                        )..show(context);
                                                                                                      } else {
                                                                                                        check[check.keys.toList()[o]].add(widget.listOfSong[widget.index].data);
                                                                                                        musicBox.put("playlists", check);
                                                                                                        Flushbar(
                                                                                                          messageText: Text("Song Added To Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                          icon: Icon(
                                                                                                            Icons.add,
                                                                                                            size: 28.0,
                                                                                                            color: kCorrect,
                                                                                                          ),
                                                                                                          shouldIconPulse: true,
                                                                                                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                          duration: Duration(seconds: 5),
                                                                                                          borderColor: Colors.white.withOpacity(0.04),
                                                                                                          borderWidth: 1,
                                                                                                          backgroundColor: glassOpacity,
                                                                                                          flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                          isDismissible: true,
                                                                                                          barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                          margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                                        )..show(context);
                                                                                                      }
                                                                                                    },
                                                                                                    child: Center(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 12),
                                                                                                        child: Text(
                                                                                                          check.keys.toList()[o],
                                                                                                          maxLines: 2,
                                                                                                          style: TextStyle(
                                                                                                            color: musicBox.get("dynamicArtDB") ?? true ? Colors.white70 : Colors.white70,
                                                                                                            fontSize: widget.car ? widget.widthOfDevice / 26 : widget.heightOfDevice / 56,
                                                                                                            shadows: [
                                                                                                              Shadow(
                                                                                                                offset: musicBox.get("dynamicArtDB") ?? true ? Offset(0, 1.0) : Offset(0, 1.0),
                                                                                                                blurRadius: musicBox.get("dynamicArtDB") ?? true ? 3.0 : 3.0,
                                                                                                                color: Colors.black54,
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(top: widget.car ? widget.widthOfDevice / 12 : widget.heightOfDevice / 25),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                } else if (i == 3) {
                                                  await Share.shareFiles(
                                                    [
                                                      widget
                                                          .listOfSong[
                                                              widget.index]
                                                          .data
                                                    ],
                                                  );
                                                } else if (i == 4) {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Ringtone(
                                                          artworkId: widget
                                                              .listOfSong[
                                                                  widget.index]
                                                              .id,
                                                          filePath: widget
                                                              .listOfSong[
                                                                  widget.index]
                                                              .data,
                                                          artist: widget
                                                              .listOfSong[
                                                                  widget.index]
                                                              .artist,
                                                          title: widget
                                                              .listOfSong[
                                                                  widget.index]
                                                              .title,
                                                          songDuration: widget
                                                                  .listOfSong[
                                                                      widget
                                                                          .index]
                                                                  .duration *
                                                              1.0),
                                                    ),
                                                  );
                                                }

                                                /// Edit Song
                                                else if (i == 5) {
                                                  Navigator.pop(context);
                                                  try {
                                                    AudioModel songInfo =
                                                        await OnAudioEdit()
                                                            .readAudio(widget
                                                                .listOfSong[
                                                                    widget
                                                                        .index]
                                                                .data);
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .size,
                                                          alignment:
                                                              Alignment.center,
                                                          duration:
                                                              dialogueAnimationDuration,
                                                          reverseDuration:
                                                              dialogueAnimationDuration,
                                                          child: SongEdit(
                                                            title:
                                                                songInfo.title,
                                                            album:
                                                                songInfo.album,
                                                            artist:
                                                                songInfo.artist,
                                                            genre:
                                                                songInfo.genre,
                                                            car: orientedCar,
                                                            heightOfDevice:
                                                                deviceHeight,
                                                            widthOfDevice:
                                                                deviceWidth,
                                                            filePath: widget
                                                                .listOfSong[
                                                                    widget
                                                                        .index]
                                                                .data,
                                                            artwork: songInfo
                                                                .firstArtwork,
                                                          )),
                                                    );                                             
                                                  } catch (e) {
                                                    Flushbar(
                                                      message:
                                                          "The File Might be Unsupported/Corrupted.",
                                                      icon: Icon(
                                                        Icons.info_outline,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ).show(context);
                                                  }
                                                  // }
                                                } else if (i == 6) {
                                                  if (await Permission.storage
                                                      .request()
                                                      .isGranted) {
                                                    await deleteAFile(widget
                                                        .listOfSong[
                                                            widget.index]
                                                        .data);
                                                    Navigator.pop(context);
                                                    await Future.delayed(
                                                        Duration(seconds: 2));

                                                    refresh = true;
                                                    rootState.provideman();
                                                  }
                                                }
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 12),
                                                  child: Text(
                                                    songMoreInfo[i],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: musicBox.get(
                                                                  "dynamicArtDB") ??
                                                              true
                                                          ? Colors.white70
                                                          : Colors.white70,
                                                      fontSize: widget.car
                                                          ? widget.widthOfDevice /
                                                              26
                                                          : widget.heightOfDevice /
                                                              56,
                                                      shadows: [
                                                        Shadow(
                                                          offset: musicBox.get(
                                                                      "dynamicArtDB") ??
                                                                  true
                                                              ? Offset(0, 1.0)
                                                              : Offset(0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: Colors.black54,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.car
                                        ? widget.widthOfDevice / 12
                                        : widget.heightOfDevice / 25),
                              ),
                            ],
                          ),
                        ),
                      ),
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

class OnHoldExtended extends StatefulWidget {
  final BuildContext context;
  final bool car;
  final double heightOfDevice;
  final double widthOfDevice;
  const OnHoldExtended({
    Key key,
    @required this.context,
    @required this.car,
    @required this.heightOfDevice,
    @required this.widthOfDevice,
  }) : super(key: key);

  @override
  _OnHoldExtendedState createState() => _OnHoldExtendedState();
}

class _OnHoldExtendedState extends State<OnHoldExtended> {
  final List songMoreInfoNP = const [
    "Share Now Playing",
    "Add To Liked Songs",
    "Add To PlayList",
    "Share File",
    "Edit File",
    "Set Ringtone",
    "Save Wallpaper",
    "Set As Home Screen",
    "Delete"
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRounded),
                    ),
                    alignment: Alignment.center,
                    width: widget.car
                        ? widget.heightOfDevice / 2
                        : widget.widthOfDevice / 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRounded),
                      child: BackdropFilter(
                        filter: glassBlur,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRounded),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.04)),
                            color: glassOpacity,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: widget.car
                                            ? widget.widthOfDevice / 12
                                            : widget.heightOfDevice / 25),
                                  ),
                                  for (int i = 0;
                                      i < songMoreInfoNP.length;
                                      i++)
                                    Material(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: SizedBox(
                                          width: widget.car
                                              ? widget.heightOfDevice
                                              : widget.widthOfDevice,
                                          height: widget.car
                                              ? widget.widthOfDevice / 6
                                              : widget.heightOfDevice / 12.5,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () async {
                                                if (i == 0) {
                                                  // Share Now Playing
                                                  await screenShotUI(false);
                                                  Directory appDocDir =
                                                      await getExternalStorageDirectory();
                                                  String appDocPath =
                                                      appDocDir.path;
                                                  await Share.shareFiles(
                                                    [
                                                      '$appDocPath/legendary-er.png'
                                                    ],
                                                  );
                                                } else if (i == 1) {
                                                  // Add to Liked Songs
                                                  if (!isSongLiked(
                                                      nowMediaItem.id)) {
                                                    rmLikedSong(
                                                        nowMediaItem.id);

                                                    Navigator.pop(context);
                                                    Flushbar(
                                                      messageText: Text(
                                                          "Removed From Liked Songs",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Futura",
                                                              color: Colors
                                                                  .white)),
                                                      icon: Icon(
                                                        Icons.block_rounded,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ).show(context);
                                                  } else {
                                                    addToLikedSong(
                                                        nowMediaItem.id);
                                                    Navigator.pop(context);
                                                    Flushbar(
                                                      messageText: Text(
                                                          "Added To Liked Songs",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Futura",
                                                              color: Colors
                                                                  .white)),
                                                      icon: Icon(
                                                        MdiIcons.heart,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )..show(context);
                                                  }
                                                } else if (i == 2) {
                                                  // add to playlist
                                                  Map check = musicBox
                                                          .get('playlists') ??
                                                      {};
                                                  if (check.keys
                                                      .toList()
                                                      .isEmpty) {
                                                    Flushbar(
                                                      messageText: Text(
                                                          "Create A Playlist First.",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Futura",
                                                              color: Colors
                                                                  .white)),
                                                      icon: Icon(
                                                        Icons
                                                            .error_outline_rounded,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ).show(context);
                                                  } else {
                                                    Navigator.pop(context);
                                                    Expanded(
                                                      child: await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (context,
                                                                StateSetter
                                                                    setState) {
                                                              return Center(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  physics:
                                                                      BouncingScrollPhysics(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 0,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(kRounded),
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width: widget.car
                                                                              ? widget.heightOfDevice / 2
                                                                              : widget.widthOfDevice / 1.2,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(kRounded),
                                                                            child:
                                                                                BackdropFilter(
                                                                              filter: glassBlur,
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(kRounded),
                                                                                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                                                                                  color: glassOpacity,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    ListView(
                                                                                      physics: BouncingScrollPhysics(),
                                                                                      shrinkWrap: true,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(top: widget.car ? widget.widthOfDevice / 12 : widget.heightOfDevice / 25),
                                                                                        ),
                                                                                        for (int o = 0; o < check.keys.toList().length; o++)
                                                                                          Material(
                                                                                            color: Colors.transparent,
                                                                                            child: Center(
                                                                                              child: SizedBox(
                                                                                                width: widget.car ? widget.heightOfDevice : widget.widthOfDevice,
                                                                                                height: widget.car ? widget.widthOfDevice / 6 : widget.heightOfDevice / 12.5,
                                                                                                child: Material(
                                                                                                  color: Colors.transparent,
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      Navigator.pop(context);
                                                                                                      if (check[check.keys.toList()[o]].contains(nowMediaItem.id)) {
                                                                                                        Flushbar(
                                                                                                          messageText: Text("Song Already In Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                          icon: Icon(
                                                                                                            Icons.error_outline_rounded,
                                                                                                            size: 28.0,
                                                                                                            color: Color(0xFFCB0447),
                                                                                                          ),
                                                                                                          shouldIconPulse: true,
                                                                                                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                          duration: Duration(seconds: 5),
                                                                                                          borderColor: Colors.white.withOpacity(0.04),
                                                                                                          borderWidth: 1,
                                                                                                          backgroundColor: glassOpacity,
                                                                                                          flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                          isDismissible: true,
                                                                                                          barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                          margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                                        )..show(context);
                                                                                                      } else {
                                                                                                        check[check.keys.toList()[o]].add(nowMediaItem.id);
                                                                                                        musicBox.put("playlists", check);
                                                                                                        Flushbar(
                                                                                                          messageText: Text("Song Added To Playlist", style: TextStyle(fontFamily: "Futura", color: Colors.white)),
                                                                                                          icon: Icon(
                                                                                                            Icons.add,
                                                                                                            size: 28.0,
                                                                                                            color: kCorrect,
                                                                                                          ),
                                                                                                          shouldIconPulse: true,
                                                                                                          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                                                                                                          duration: Duration(seconds: 5),
                                                                                                          borderColor: Colors.white.withOpacity(0.04),
                                                                                                          borderWidth: 1,
                                                                                                          backgroundColor: glassOpacity,
                                                                                                          flushbarStyle: FlushbarStyle.FLOATING,
                                                                                                          isDismissible: true,
                                                                                                          barBlur: musicBox.get("glassBlur") == null ? 18 : musicBox.get("glassBlur"),
                                                                                                          margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
                                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                                        )..show(context);
                                                                                                      }
                                                                                                    },
                                                                                                    child: Center(
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsets.only(left: 12),
                                                                                                        child: Text(
                                                                                                          check.keys.toList()[o],
                                                                                                          maxLines: 2,
                                                                                                          style: TextStyle(
                                                                                                            color: musicBox.get("dynamicArtDB") ?? true ? Colors.white70 : Colors.white70,
                                                                                                            fontSize: widget.car ? widget.widthOfDevice / 26 : widget.heightOfDevice / 56,
                                                                                                            shadows: [
                                                                                                              Shadow(
                                                                                                                offset: musicBox.get("dynamicArtDB") ?? true ? Offset(0, 1.0) : Offset(0, 1.0),
                                                                                                                blurRadius: musicBox.get("dynamicArtDB") ?? true ? 3.0 : 3.0,
                                                                                                                color: Colors.black54,
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(top: widget.car ? widget.widthOfDevice / 12 : widget.heightOfDevice / 25),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                } else if (i == 3) {
                                                  await Share.shareFiles(
                                                    [nowMediaItem.id],
                                                  );
                                                }

                                                /// Edit Song
                                                else if (i == 4) {
                                                  Navigator.pop(context);
                                                  try {
                                                    final AudioModel songInfo =
                                                        await OnAudioEdit()
                                                            .readAudio(
                                                                nowMediaItem
                                                                    .id);
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .size,
                                                        alignment:
                                                            Alignment.center,
                                                        duration:
                                                            dialogueAnimationDuration,
                                                        reverseDuration:
                                                            dialogueAnimationDuration,
                                                        child: SongEdit(
                                                          title: songInfo.title,
                                                          album: songInfo.album,
                                                          artist:
                                                              songInfo.artist,
                                                          genre: songInfo.genre,
                                                          car: orientedCar,
                                                          heightOfDevice:
                                                              deviceHeight,
                                                          widthOfDevice:
                                                              deviceWidth,
                                                          filePath:
                                                              nowMediaItem.id,
                                                          artwork: songInfo
                                                              .firstArtwork,
                                                        ),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    Flushbar(
                                                      message:
                                                          "The File Might be Unsupported/Corrupted.",
                                                      icon: Icon(
                                                        Icons.info_outline,
                                                        size: 28.0,
                                                        color:
                                                            Color(0xFFCB0447),
                                                      ),
                                                      shouldIconPulse: true,
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor:
                                                          glassOpacity,
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: musicBox.get(
                                                                  "glassBlur") ==
                                                              null
                                                          ? 18
                                                          : musicBox
                                                              .get("glassBlur"),
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )..show(context);
                                                  }
                                                  // }
                                                } else if (i == 5) {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Ringtone(
                                                          artworkId:
                                                              nowMediaItem
                                                                  .extras['id'],
                                                          filePath:
                                                              nowMediaItem.id,
                                                          artist: nowMediaItem
                                                              .artist,
                                                          title: nowMediaItem
                                                              .title,
                                                          songDuration: nowMediaItem
                                                                  .duration
                                                                  .inMilliseconds *
                                                              1.0),
                                                    ),
                                                  );
                                                } else if (i == 6) {
                                                  // Save Wallpaper
                                                  if (await Permission.storage
                                                          .request()
                                                          .isGranted
                                                      //     &&
                                                      // await Permission
                                                      //     .manageExternalStorage
                                                      //     .request()
                                                      //     .isGranted
                                                      ) {
                                                    Navigator.pop(context);

                                                    Flushbar(
                                                      messageText: Text(
                                                          "Saved In Downloads Directory",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Futura",
                                                              color: Colors
                                                                  .white)),
                                                      icon: Icon(
                                                        MdiIcons.image,
                                                        size: 28.0,
                                                        color: kCorrect,
                                                      ),

                                                      shouldIconPulse: true,
                                                      dismissDirection:
                                                          FlushbarDismissDirection
                                                              .HORIZONTAL,
                                                      duration:
                                                          Duration(seconds: 5),
                                                      borderColor: Colors.white
                                                          .withOpacity(0.04),
                                                      borderWidth: 1,
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.05),
                                                      flushbarStyle:
                                                          FlushbarStyle
                                                              .FLOATING,
                                                      isDismissible: true,
                                                      barBlur: 20,
                                                      margin: EdgeInsets.only(
                                                          bottom: 20,
                                                          left: 8,
                                                          right: 8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      // leftBarIndicatorColor:
                                                      //     Color(0xFFCB0047),
                                                    )..show(context);
                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                    await screenShotUI(true);
                                                  }
                                                } else if (i == 7) {
                                                  // set as home screen
                                                  Navigator.pop(context);
                                                  await screenShotUI(false);
                                                  await setHomeScreenWallpaper();
                                                } else if (i == 8) {
                                                  if (await Permission.storage
                                                      .request()
                                                      .isGranted) {
                                                    await deleteAFile(
                                                        songList[indexOfList]
                                                            .data);
                                                    Navigator.pop(context);
                                                    await Future.delayed(
                                                        Duration(seconds: 2));

                                                    refresh = true;
                                                    rootState.provideman();
                                                  }
                                                }
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 12),
                                                  child: Text(
                                                    i == 1
                                                        ? !isSongLiked(
                                                                nowMediaItem.id)
                                                            ? "Remove From Liked Songs"
                                                            : "Add to Liked Songs"
                                                        : songMoreInfoNP[i],
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: musicBox.get(
                                                                  "dynamicArtDB") ??
                                                              true
                                                          ? Colors.white70
                                                          : Colors.white70,
                                                      fontSize: widget.car
                                                          ? widget.widthOfDevice /
                                                              26
                                                          : widget.heightOfDevice /
                                                              56,
                                                      shadows: [
                                                        Shadow(
                                                          offset: musicBox.get(
                                                                      "dynamicArtDB") ??
                                                                  true
                                                              ? Offset(0, 1.0)
                                                              : Offset(0, 1.0),
                                                          blurRadius: musicBox.get(
                                                                      "dynamicArtDB") ??
                                                                  true
                                                              ? 3.0
                                                              : 3.0,
                                                          color: Colors.black54,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: widget.car
                                        ? widget.widthOfDevice / 12
                                        : widget.heightOfDevice / 25),
                              ),
                            ],
                          ),
                        ),
                      ),
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
