// Dart imports:
import 'dart:convert';
import 'dart:core';

// Package imports:
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:phoenix/src/beginning/utilities/audio_handlers/previous_play_skip.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import '../has_network.dart';

class Lyrics {
  final String _url = "https://www.google.com/search?q=";
  final String _url2 = "https://api.lyrics.ovh/v1";
  String _delimiter1 =
      '</div></div></div></div><div class="hwc"><div class="BNeawe tAd8D AP7Wnd"><div><div class="BNeawe tAd8D AP7Wnd">';
  String _delimiter2 =
      '</div></div></div></div></div><div><span class="hwc"><div class="BNeawe uEec3 AP7Wnd">';

  Lyrics({delimiter1, delimiter2}) {
    setDelimiters(delimiter1: delimiter1, delimiter2: delimiter2);
  }

  void setDelimiters({String? delimiter1, String? delimiter2}) {
    _delimiter1 = delimiter1 ?? _delimiter1;
    _delimiter2 = delimiter2 ?? _delimiter2;
  }

  getLyrics({String? track, String? artist, String? path}) async {
    String lyrics;
    onGoingProcess = true;
    if (track == null) throw Exception("track must not be null");

    // Check if device is connected to the internet
    if (!await hasNetwork()) {
      return (["Couldn't find any matching lyrics.", path]);
    }

    // Scraping lyrics from https://api.lyrics.ovh
    if (artist != " ") {
      String? firstLyric;
      try {
        firstLyric = jsonDecode(
            (await http.get(Uri.parse(Uri.encodeFull('$_url2/$artist/$track'))))
                .body)["lyrics"];
      } catch (e) {
        firstLyric = null;
      }
      if (firstLyric != null) {
        if (firstLyric.contains(
            "Mercedes Benz\nSponsored by Mercedes Benz\nEssayez la Classe A !\nSee More")) {
          firstLyric = firstLyric.replaceAll(
              "Mercedes Benz\nSponsored by Mercedes Benz\nEssayez la Classe A !\nSee More",
              "");
        }
        if (firstLyric.contains("???")) {
          firstLyric = firstLyric.replaceAll("???", "");
        }
        if (firstLyric.contains("\n\n")) {
          firstLyric = firstLyric.replaceAll("\n\n", "\n");
        }
        if (firstLyric.contains("Paroles de la chanson")) {
          firstLyric =
              firstLyric.replaceRange(0, firstLyric.indexOf("\n") + 1, "");
        }
        return [firstLyric, path];
      }
    }

    /// Credits to Sjoerd Bolten - https://github.com/Netlob/dart-lyrics
    /// Scraping lyrics from Google.
    if (artist == " ") {
      try {
        lyrics =
            (await http.get(Uri.parse(Uri.encodeFull('$_url$track lyrics'))))
                .body;
        lyrics = lyrics.split(_delimiter1).last;
        lyrics = lyrics.split(_delimiter2).first;
        if (lyrics.contains('<meta charset="UTF-8">')) throw Error();
      } catch (_) {
        return (["Couldn't find any matching lyrics.", path]);
      }
    } else {
      try {
        lyrics = (await http.get(
                Uri.parse(Uri.encodeFull('$_url$track by $artist lyrics'))))
            .body;

        lyrics = lyrics.split(_delimiter1).last;
        lyrics = lyrics.split(_delimiter2).first;
        if (lyrics.contains('<meta charset="UTF-8">')) throw Error();
      } catch (_) {
        try {
          lyrics = (await http.get(Uri.parse(
                  Uri.encodeFull('$_url$track by $artist song lyrics'))))
              .body;
          lyrics = lyrics.split(_delimiter1).last;
          lyrics = lyrics.split(_delimiter2).first;
          if (lyrics.contains('<meta charset="UTF-8">')) throw Error();
        } catch (_) {
          try {
            lyrics = (await http.get(Uri.parse(Uri.encodeFull(
                    '$_url${track.split("-").first} by $artist lyrics'))))
                .body;
            lyrics = lyrics.split(_delimiter1).last;
            lyrics = lyrics.split(_delimiter2).first;
            if (lyrics.contains('<meta charset="UTF-8">')) throw Error();
          } catch (_) {
            return (["Couldn't find any matching lyrics.", path]);
          }
        }
      }
    }

    final List<String> split = lyrics.split('\n');
    String result = '';
    for (var i = 0; i < split.length; i++) {
      result = '$result${split[i]}\n';
    }
    return [result.trim(), path];
  }
}

lyricsFetch(songArtist, songName, songData) async {
  lyricsDat = "Searching...";
  List lyrics = await Lyrics()
      .getLyrics(artist: songArtist, track: songName, path: songData);
  if (onGoingProcess) {
    if (lyrics[1] == nowMediaItem.id) {
      lyricsDat = "";
      String anotherLyrics = lyrics[0];
      onGoingProcess = false;
      if (anotherLyrics
          .contains("Sometimes you may be asked to solve the CAPTCHA")) {
        anotherLyrics = "Couldn't find any matching lyrics.";
        throw Exception("CAPTCH-MATE");
      }
      if (anotherLyrics.contains("</div>")) {
        anotherLyrics = anotherLyrics.replaceRange(
            anotherLyrics.indexOf("</div>"), anotherLyrics.length, "");
      }
      lyricsDat = HtmlUnescape().convert(anotherLyrics);
      saveLyrics(lyrics[1], lyricsDat);
    }
  }
}
