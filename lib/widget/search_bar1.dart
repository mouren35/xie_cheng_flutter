import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBar1 extends StatefulWidget {
  final String? hint;
  final String defaultText;
  final bool enabled;
  final bool? hideLeft;
  final SearchBarType? searchBarType;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar1({
    super.key,
    this.enabled = true,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    required this.defaultText,
    required this.leftButtonClick,
    required this.rightButtonClick,
    required this.speakClick,
    required this.inputBoxClick,
    required this.onChanged,
  });

  @override
  State<SearchBar1> createState() => _SearchBar1State();
}

class _SearchBar1State extends State<SearchBar1> {
  bool showClear = false; //是否显示清除按钮
  final TextEditingController _controller = TextEditingController(); //搜索框

  @override
  void initState() {
    setState(() {
      _controller.text = widget.defaultText; //语音输入跳到搜索框
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  // search_page_search_bar
  _genNormalSearch() {
    return Container(
      child: Row(
        children: [
          // left
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft ?? false
                  ? null
                  : const Icon(Icons.arrow_back, color: Colors.grey, size: 26),
            ),
            widget.leftButtonClick,
          ),
          // center_searchbar
          Expanded(flex: 1, child: _inputBox()),
          // right_icon
          _wrapTap(
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: const Text(
                '搜索',
                style: TextStyle(color: Colors.blue, fontSize: 27),
              ),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  // home_page_search_bar
  _genHomeSearch() {
    return Container(
      child: Row(
        children: [
          // left
          _wrapTap(
              Container(
                padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: [
                    Text(
                      '上海',
                      style: TextStyle(fontSize: 14, color: _homeFrontColor()),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFrontColor(),
                      size: 22,
                    )
                  ],
                ),
              ),
              widget.leftButtonClick),
          // center_searchbar
          Expanded(flex: 1, child: _inputBox()),
          // right_icon
          _wrapTap(
            Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFrontColor(),
                  size: 22,
                )),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  // searchbar
  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      // note:30? 0r 50?
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 5 : 15,
        ),
      ),
      child: Row(
        children: [
          // left_icon
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? const Color(0xffA9A9A9)
                : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: true,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      border: InputBorder.none,
                      hintText: widget.hint ?? '',
                      hintStyle: const TextStyle(fontSize: 15),
                    ),
                  )
                : _wrapTap(
                    Container(
                      child: Text(
                        widget.defaultText!,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ),
                    widget.inputBoxClick,
                  ),
          ),
          !showClear
              ? _wrapTap(
                  Icon(
                    Icons.mic,
                    size: 22,
                    color: widget.searchBarType == SearchBarType.normal
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  widget.speakClick,
                )
              : _wrapTap(
                  const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  _homeFrontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}
