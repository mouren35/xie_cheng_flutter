import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/search_bar1.dart';

import '../model/home_model.dart';
import '../widget/grid_nav.dart';
import '../widget/local_nav.dart';
import '../widget/sales_box.dart';
import '../widget/sub_nav.dart';
import '../widget/webview.dart';

const appBarScrollOffset = 100;
const searchBarDefaultText = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel? gridNavModel;
  SalesBoxModel? salesBoxModel;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  _onScroll(double pixels) {
    double alpha = pixels / appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    // print(_appBarAlpha);
  }

  Future<void> _handleRefresh() async {
    // HomeDao.fetch().then((result) {
    //   setState(() {
    //     resultString = json.encode(result);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });

    // try {
    HomeModel model = await HomeDao.fetch();
    setState(() {
      localNavList = model.localNavList;
      subNavList = model.subNavList;
      gridNavModel = model.gridNav;
      salesBoxModel = model.salesBox;
      bannerList = model.bannerList;
      _loading = false;
    });
    // }
    // catch (e) {
    //   setState(() {
    //     _loading = false;
    //   });
    //   // print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return false; //改为false才可以下拉刷新
                  },
                  child: _listView,
                ),
              ),
            ),
            _appBar,
          ],
        ),
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: [
        _banner,
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color:
                  Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar1(
              searchBarType: _appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: searchBarDefaultText,
              leftButtonClick: () {},
              rightButtonClick: () {},
              onChanged: (String value) {},
            ),
          ),
        ),
        Container(
          height: _appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 160,
      child: Swiper(
          itemCount: bannerList.length,
          autoplay: true,
          pagination: const SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      CommonModel model = bannerList[index];
                      return WebView(
                        url: model.url,
                        statusBarColor: '',
                        title: model.title,
                        hideAppBar: model.hideAppBar,
                      );
                    },
                  ),
                );
              },
              child: Image.network(
                bannerList[index].icon!,
                fit: BoxFit.fill,
              ),
            );
          }),
    );
  }

  void _jumpToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchPage(
          hint: searchBarDefaultText,
          keyword: '',
        ),
      ),
    );
  }

  void _jumpToSpeak() {}
}
