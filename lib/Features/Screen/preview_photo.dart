import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PreviewPhoto extends StatefulWidget {
  final String massage;
  final ImageProvider provider;
   final bool willSent;

  const PreviewPhoto({super.key, required this.massage,required this.provider, required this.willSent});

  @override
  _PreviewPhotoState createState() => _PreviewPhotoState();
}

class _PreviewPhotoState extends State<PreviewPhoto> {
  PageController scrollController = PageController();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:BLACK,
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 56,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: PhotoView(
                imageProvider: widget.provider,
              ),
            ),
            Center(
                child: InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
               },
              child: Container(
                width: 120,height: 50,
                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).accentColor.withOpacity(0.3)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          widget.willSent
                              ? "ارسال"
                              : "Upload",
                          style:Theme.of(context).textTheme.headline6?.copyWith(
                            color: WHITE,fontSize: 16,
                          )),
                    ],
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
