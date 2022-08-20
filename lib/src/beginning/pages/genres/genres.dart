// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phoenix/src/beginning/pages/genres/genres_inside.dart';
import 'package:phoenix/src/beginning/utilities/constants.dart';
import 'package:phoenix/src/beginning/utilities/global_variables.dart';
import 'package:phoenix/src/beginning/utilities/init.dart';
import 'package:phoenix/src/beginning/utilities/provider/provider.dart';
import 'package:phoenix/src/beginning/widgets/dialogues/awakening.dart';
import '../../utilities/page_backend/genres_back.dart';

late int genreSelected;
List<SongModel>? genreSongs;
List<MediaItem> genreMediaItems = [];

class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> with AutomaticKeepAliveClientMixin {
  ScrollController? _scrollBarController;
  @override
  void initState() {
    _scrollBarController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (ascend) {
      return Scrollbar(
        controller: _scrollBarController,
        child: RefreshIndicator(
          backgroundColor:
              musicBox.get("dynamicArtDB") ?? true ? nowColor : Colors.white,
          color: musicBox.get("dynamicArtDB") ?? true
              ? nowContrast
              : kMaterialBlack,
          onRefresh: () async {
            await fetchAll();
          },
          child: ListView.builder(
            controller: _scrollBarController,
            padding: const EdgeInsets.only(top: 5, bottom: 8),
            addAutomaticKeepAlives: true,
            itemExtent: orientedCar ? deviceWidth! / 1.4 : deviceWidth! / 2,
            physics: musicBox.get("fluidAnimation") ?? true
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics(),
            itemCount: musicBox.get('customScan') ?? false
                ? insideAllGenreData.length
                : allgenres.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: orientedCar ? deviceHeight! / 3 : deviceWidth! / 2,
                width: orientedCar ? deviceHeight : deviceWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: deviceWidth! / 25),
                    ),
                    Container(
                      width: orientedCar
                          ? deviceHeight! / 1.4
                          : deviceWidth! / 1.05,
                      height: orientedCar
                          ? deviceHeight! / 3.3
                          : deviceWidth! / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRounded),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(glassShadowOpacity! / 100),
                            blurRadius: glassShadowBlur,
                            offset: kShadowOffset,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kRounded),
                        child: BackdropFilter(
                          filter: glassBlur,
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(kRounded),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRounded),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.04)),
                                color: glassOpacity,
                              ),
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () async {
                                  genreSelected = index;
                                  await fetchGenreSongs(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider<SortProvider>(
                                            create: (_) => SortProvider(),
                                          ),
                                          ChangeNotifierProvider<Leprovider>(
                                            create: (_) => Leprovider(),
                                          ),
                                        ],
                                        builder: (context, child) =>
                                            const GenresInside(),
                                      ),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ChangeNotifierProvider<Leprovider>(
                                  //       create: (_) => Leprovider(),
                                  //       builder: (context, child) =>
                                  //           const GenresInside(),
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Center(
                                  child: Text(
                                    musicBox.get('customScan') ?? false
                                        ? insideAllGenreData.keys
                                            .toList()[index]
                                        : allgenres[index].genre,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: deviceWidth! / 20,
                                      fontWeight: FontWeight.w600,
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
              );
            },
          ),
        ),
      );
    }
    {
      return orientedCar
          ? const SingleChildScrollView(child: Awakening())
          : const Awakening();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
