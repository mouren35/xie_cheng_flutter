import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController? _controller;
  List<TravelTab> tabs = [];
  TravelTabModel? travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    _loadData();
    super.initState();
  }

  _loadData() async {
    await TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs!.length, vsync: this);
      setState(() {
        tabs = model.tabs!;
        travelTabModel = model;
      });
    });
    //     .catchError((e) {
    //   print(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 30),
              child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                  insets: EdgeInsets.only(bottom: 10),
                ),
                tabs: tabs.map((TravelTab tab) {
                  return Tab(text: tab.labelName);
                }).toList(),
              ),
            ),
            Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((TravelTab tab) {
                    return TravelTabPage(
                      travelUrl: travelTabModel!.url!,
                      groupChannelCode: tab.groupChannelCode!,
                    );
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
