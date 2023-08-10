import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

class ImageList extends StatefulWidget {
  final PageController pageController;
  final int index;
  final imageList;
  ImageList({Key? key, this.index = 0, required this.imageList})
      : pageController = PageController(initialPage: index),
        super(key: key);

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.imageList.length,
            builder: (context, index) {
              final urlImage = widget.imageList[index].imageT;
              
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(urlImage),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            onPageChanged: (index) => setState(() {
              this.index = index;
            }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  7, MediaQuery.of(context).size.height * 0.05, 7, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Text(
                            "${index + 1}/${widget.imageList.length}",
                            style: TextStyle(
                              fontFamily: "aclonica",
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 11.5),
                          ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
