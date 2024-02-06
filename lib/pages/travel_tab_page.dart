import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/webview.dart';

const _travelUrl =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

const pageSize = 10;

class TravelTabPage extends StatefulWidget {
  final String? travelUrl;
  final String groupChannelCode;

  const TravelTabPage({
    super.key,
    required this.travelUrl,
    required this.groupChannelCode,
  });

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem>? travelItems = [];
  int pageIndex = 1;
  bool _loading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh(),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: MasonryGridView.count(
              controller: _scrollController,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: travelItems?.length ?? 0,
              itemBuilder: (context, index) =>
                  _TravelItem(index: index, item: travelItems![index]),
            ),
          ),
        ),
      ),
    );
  }

  void _loadData({loadMore = false}) async {
    if (loadMore) {
      ++pageIndex;
    } else {
      pageIndex = 1;
    }
    await TravelDao.fetch(
      widget.travelUrl ?? _travelUrl,
      widget.groupChannelCode,
      pageIndex,
      pageSize,
    ).then((model) {
      _loading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems = items;
        } else {
          travelItems = items;
        }
      });
    });
  }

  List<TravelItem> _filterItems(List<TravelItem>? resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var item in resultList) {
      if (item.article != null) {
        // 移除article为空的模型
        filterItems.add(item);
      }
    }
    return filterItems;
  }

  @override
  bool get wantKeepAlive => true;

  _handleRefresh() async {
    _loadData();
  }
}

class _TravelItem extends StatelessWidget {
  final int index;
  final TravelItem item;

  const _TravelItem({required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article?.urls != null && item.article!.urls!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView(
                url: item.article!.urls?[0].h5Url,
                title: '详情',
              ),
            ),
          );
        }
      },
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemImage(),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                item.article!.articleTitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            _infoText(),
          ],
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: [
        Image.network(item.article!.images![0].dynamicUrl!),
        Positioned(
          left: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    size: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        LimitedBox(
          maxWidth: 130,
          child: Text(
            _poiName(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article?.pois?.length == 0
        ? '未知'
        : item.article?.pois?[0].poiName ?? '未知';
  }

  _infoText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article!.author!.coverImage!.dynamicUrl!,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article!.author!.nickName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.thumb_up, size: 14, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  item.article!.likeCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
