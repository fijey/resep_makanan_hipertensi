import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:resep_makanan_hipertensi/src/controller/FavoriteController.dart';
import 'package:resep_makanan_hipertensi/src/data/data.dart';
import 'package:resep_makanan_hipertensi/src/widget/favorite_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String>? _favorite = [];

  @override
  void initState() {
    super.initState();
    getFavorite().then((value) {
      if (value != null) {
        setState(() {
          _favorite = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Container> assetsWidgets = [];
    List<Map<String, dynamic>> daftar_isi = data_daftar_isi;
    for (var i = 1; i <= 104; i++) {
      String imagePath = 'assets/resep/page ($i).jpg';
      assetsWidgets.add(
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Map<String, dynamic> data = daftar_isi[i];
                      // downloadImage(
                      //     'assets/resep/page ($i).jpg', data['nama_halaman']);
                      // // Code to download the image goes here
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.orange.shade900,
                    ),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      _favorite = prefs.getStringList('favorite') ?? [];

                      if (_favorite?.isNotEmpty == true) {
                        if (_favorite!.contains(i.toString())) {
                          _favorite?.remove(i.toString());
                        }
                      }
                      prefs.setStringList('favorite', _favorite!);
                      print(prefs.getStringList('favorite'));

                      setState(() {
                        _favorite = prefs.getStringList('favorite');
                      });

                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: "Sukses",
                          text: "Berhasil Dihapus Dari Favorite");
                      // Code to save the image to favorites goes here
                    },
                  ),
                ],
              ),
              Expanded(
                child: Image(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fitWidth,
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Daftar Isi Halaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade900,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: 91,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data = daftar_isi[index];
                            return ListTile(
                              leading: Text(
                                '${data['nama_halaman']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${data['page']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                // Code to navigate to the corresponding page goes here
                                SwipeImageGallery swipeGallery =
                                    SwipeImageGallery(
                                        context: context,
                                        children: assetsWidgets,
                                        initialIndex: data['page'] - 1);
                                swipeGallery.show();
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.orange.shade900,
      appBar: AppBar(
        title: Text('Resep Favorit'),
        backgroundColor: Colors.orange.shade900,
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          children: _favorite!
              .map((item) => FavoriteItem(
                    assetsWidgets: assetsWidgets,
                    item: item,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
