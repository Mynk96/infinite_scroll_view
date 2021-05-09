import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_community/model/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({
    @required this.design,
    Key key,
  })  : assert(design != null),
        super(key: key);

  final Design design;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Material(
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () =>
                  {_launchInWebViewWithJavaScript(design.designPageUrl)},
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: design.imageUrl,
                    height: 260,
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 10, 15),
                    //color: Colors.orange,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Text('${design.title}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left)),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {
                                    print('hello');
                                  },
                                  color: Colors.pink,
                                )),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    icon: Icon(Icons.ios_share),
                                    onPressed: () {
                                      Share.share(design.designPageUrl);
                                    }))
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Text(
                          timeago.format(design.publishedTime),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: SvgPicture.asset(
                            'assets/Unsplash_Logo_Full.svg',
                            alignment: Alignment.bottomLeft,
                          ),
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
