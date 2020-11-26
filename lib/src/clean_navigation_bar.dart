import 'dart:ui';
import 'package:clean_bottom_navigation_bar/src/clean_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class CleanNavigationBar extends StatefulWidget {
  int currentIndex;
  final bool showFab;
  final int fab;
  final double cornerRadius;
  final double barHeight;
  final double fabHeight;
  final double indicatorHeight;
  final Color activeColor;
  final Color tabColor;
  final Color indicatorColor;
  final TextStyle titleStyle;
  final ValueChanged<int> onTap;
  final List<CleanNavigationBarItem> items;

  CleanNavigationBar({
    Key key,
    this.showFab = true,
    this.fab = 2,
    this.currentIndex = 0,
    this.cornerRadius = 20,
    this.barHeight = 60,
    this.fabHeight = 0 - (60 / 2),
    this.indicatorHeight = 4,
    this.activeColor,
    this.tabColor,
    this.indicatorColor,
    this.titleStyle,
    @required this.onTap,
    @required this.items,
  }) : super(key: key);

  @override
  _NeatNavigationBarState createState() => _NeatNavigationBarState();
}

class _NeatNavigationBarState extends State<CleanNavigationBar> {
  double get BAR_HEIGHT => widget.barHeight;
  double get INDICATOR_HEIGHT => widget.indicatorHeight;
  List<CleanNavigationBarItem> get items => widget.items;

  double BAR_ITEM_WIDTH = 0;
  Duration duration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    double BAR_ITEM_WIDTH = MediaQuery.of(context).size.width / items.length;
    return Container(
      height: BAR_HEIGHT + MediaQuery.of(context).viewPadding.bottom,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: widget.activeColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.cornerRadius),
          topRight: Radius.circular(widget.cornerRadius),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            top: INDICATOR_HEIGHT,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                    onTap: () => _select(index),
                    child: _buildItem(
                        item,
                        index == widget.currentIndex,
                        (index == widget.fab)
                            ? (widget.showFab)
                                ? true
                                : false
                            : false));
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: AnimatedAlign(
              alignment:
                  Alignment(_getIndicatorPosition(widget.currentIndex), 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                width: BAR_ITEM_WIDTH,
                height: INDICATOR_HEIGHT,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: (BAR_ITEM_WIDTH / 4),
                      color: Color(0x00000000),
                    ),
                    Container(
                      width: (BAR_ITEM_WIDTH / 2),
                      decoration: BoxDecoration(
                        color: widget.indicatorColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: (BAR_ITEM_WIDTH / 4),
                      color: Color(0x00000000),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.showFab)
            Positioned(
              top: widget.fabHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return (index == widget.fab)
                      ? GestureDetector(
                          onTap: () => _select(widget.fab),
                          child: _buildButton(item, index == widget.fab))
                      : Container(
                          width:
                              MediaQuery.of(context).size.width / items.length);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  _select(int index) {
    widget.currentIndex = index;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  Widget _buildIcon(CleanNavigationBarItem item, bool active, bool fab) {
    return Icon(
      item.icon,
      color: fab ? widget.activeColor : widget.tabColor,
    );
  }

  Widget _buildText(CleanNavigationBarItem item, bool active) {
    return DefaultTextStyle.merge(
      child: item.title,
      style: widget.titleStyle,
    );
  }

  Widget _buildItem(CleanNavigationBarItem item, bool active, bool fab) {
    return Container(
      height: BAR_HEIGHT,
      width: MediaQuery.of(context).size.width / items.length,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: _buildIcon(item, active, fab),
          ),
          _buildText(item, active),
        ],
      ),
    );
  }

  Widget _buildButton(CleanNavigationBarItem item, bool fab) {
    return Container(
      width: MediaQuery.of(context).size.width / items.length,
      child: AnimatedContainer(
        child: _buildIcon(item, fab, true),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (widget.currentIndex == widget.fab)
              ? widget.indicatorColor
              : widget.tabColor,
        ),
        width: (MediaQuery.of(context).size.width / items.length) * (70 / 100),
        height: (MediaQuery.of(context).size.width / items.length) * (70 / 100),
        duration: duration,
      ),
    );
  }
}
