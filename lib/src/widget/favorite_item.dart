import 'package:flutter/material.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    Key? key,
    required this.assetsWidgets,
    required this.item,
  }) : super(key: key);

  final List<Container> assetsWidgets;
  final String item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Code untuk aksi ketika gambar di klik
        SwipeImageGallery swipeGallery = SwipeImageGallery(
            context: context,
            children: assetsWidgets,
            initialIndex: int.parse(item) - 1);
        swipeGallery.show();
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/resep/page (${int.parse(item)}).jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
