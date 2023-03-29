import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:resep_makanan_hipertensi/src/data/data.dart';
import 'package:resep_makanan_hipertensi/src/page/favorite_screen.dart';
import 'package:resep_makanan_hipertensi/src/page/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OnBoardingPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> assetsWidgets = [];
    List<String>? _favorite = [];
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
                      // Code to download the image goes here
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.orange.shade900,
                    ),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      _favorite = prefs.getStringList('favorite') ?? [];

                      if (!_favorite!.contains(i.toString())) {
                        _favorite?.add(i.toString());
                      }

                      prefs.setStringList('favorite', _favorite!);
                      print(prefs.getStringList('favorite'));

                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: "Sukses",
                          text: "Berhasil Menambahkan Ke Favorite");
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resep Makanan Untuk Hipertensi",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.orange.shade900,
                child: InkWell(
                  onTap: () => SwipeImageGallery(
                    context: context,
                    children: assetsWidgets,
                  ).show(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 64.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Lihat Resep',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.orange.shade900,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoritePage()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        size: 64.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Resep Favorit',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
