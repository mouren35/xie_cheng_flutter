import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/webview.dart';

import '../widget/search_bar1.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

const url =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? searchUrl;
  final String keyword;
  final String? hint;

  const SearchPage({
    super.key,
    this.hideLeft,
    this.searchUrl = url,
    required this.keyword,
    this.hint,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? keyword;
  SearchModel? searchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: searchModel?.data.length ?? 0,
                itemBuilder: (BuildContext context, int position) {
                  return _item(position);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _onTextChange(String text) async {
    keyword = text;
    if (text.isEmpty) {
      setState(() {
        searchModel = SearchModel(data: []);
      });
      return;
    }
    String url = widget.searchUrl! + text;
    await SearchDao.fetch(url, text).then((SearchModel model) {
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    });
    //     .catchError((e) {
    //   print(e);
    // });
  }

  _appBar() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent], //transparent透明
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            decoration: const BoxDecoration(color: Colors.white),
            child: SearchBar1(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
              rightButtonClick: () {},
              speakClick: () {},
              inputBoxClick: () {},
            ),
          ),
        )
      ],
    );
  }

  _item(int position) {
    if (searchModel == null || searchModel?.data == null) return null;
    SearchItem? item = searchModel?.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView(url: item!.url, title: '详情'),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item?.type)),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _typeImage(String? type) {
    String path = 'travelgroup';
    if (type == null) {
      return 'assets/images/type_travelgroup.png'; //note:assets也要写
    }
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'assets/images/type_$path.png';
  }

  _title(SearchItem? item) {
    if (item == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel?.keyword));
    spans.add(
      TextSpan(
        text: ' ${item.districtname ?? ''} ${item.zonename ?? ''}',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem? item) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: item?.price ?? '',
        style: const TextStyle(fontSize: 12, color: Colors.orange),
      ),
      TextSpan(
        text: ' ${item?.star ?? ''}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ]));
  }

  _keywordTextSpans(String? word, String? keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    List<String> arr = word.split(keyword as Pattern);
    TextStyle normalStyle =
        const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle =
        const TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; ++i) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
