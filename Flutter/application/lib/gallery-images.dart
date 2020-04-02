import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class GalleryImages extends StatefulWidget {
  String keyword;
  GalleryImages(this.keyword);
  @override
  _GalleryImagesState createState() => _GalleryImagesState();
}

class _GalleryImagesState extends State<GalleryImages> {
  ScrollController _scrollController = new ScrollController();
  int currentPage = 1;
  int size = 10;
  int totalPages;
  var images;
  List<dynamic> hits;

  getData() {
    String url =
        "https://pixabay.com/api/?key=14556280-fdf35136e57d0e94ad0bc29de&q=${widget.keyword}&page=$currentPage&per_page=10";
    http.get(url).then((resp) {
      setState(() {
        images = json.decode(resp.body);
        hits = images['hits'];
        if(images['totalHits']%size==0)
        totalPages=(images['totalHits']~/size);
        else
        totalPages=1+(images['totalHits']/size).floor();
        print(hits);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    this._scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        if(currentPage < totalPages){
          ++currentPage;
          this.getData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
           "${widget.keyword.toUpperCase()} , Page : $currentPage/$totalPages",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: (images == null)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: images == null ? 0 : images.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          child: Card(
                            child: Center(
                              child: Text(
                                hits[index]['tags']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                            child: Image.network(
                          hits[index]['webformatURL'],
                          fit: BoxFit.fitWidth,
                        )),
                      )
                    ],
                  );
                },
              ));
  }
}
