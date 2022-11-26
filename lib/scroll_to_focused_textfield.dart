library scroll_to_focused_textfield;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 创建时间：2022/11/26
/// 作者：LinMingQuan
/// 描述：当软键盘弹出时，
/// 如果持有焦点的输入框(TextField)被遮挡，把输入框往上滚动，使输入框可见。
///
///          注意：输入框必须在可滚动组件内
///

class ScrollToFocusedTextField extends StatefulWidget {
  const ScrollToFocusedTextField({Key? key,
    required this.child,
    this.enable = true,
    this.offsetSize = 35,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
  }) : super(key: key);
  final Widget child;
  final bool enable;
  final double offsetSize;
  final Duration duration;
  final Curve curve;
  @override
  State<ScrollToFocusedTextField> createState() => _ScrollToFocusedTextFieldState();
}

class _ScrollToFocusedTextFieldState extends State<ScrollToFocusedTextField> {

  StreamSubscription? _subscription;

  /// 检查持有焦点的组件是否被软键盘遮挡
  void _scrollToFocused(){
    /// 当前焦点
    FocusNode? focused = FocusScope.of(context).focusedChild;
    if(focused != null){
      /// 持有焦点组件在屏幕中的位置范围
      Rect focusedRect = focused.rect;

      /// 软键盘顶部在屏幕中的位置
      double keyboardTop = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
      if(focused.context != null){
        ScrollableState? scrollState = Scrollable.of(focused.context!);
        if(scrollState != null){
          ScrollPosition position = scrollState.position;

          if(focusedRect.bottom < (keyboardTop)){
            return ;
          }

          /// 组件大部分被软件盘遮挡或完全遮挡，适当往上滚动
          position.animateTo(
              position.pixels + (focusedRect.top - keyboardTop) + (focusedRect.bottom - focusedRect.top),
              duration: widget.duration,
              curve: widget.curve);
        }
      }
    }
  }

  void _onKeyboardShowing(){
    _subscription?.cancel();
    _subscription = Future.delayed(const Duration(milliseconds: 100)).asStream().listen((event) {
      _scrollToFocused();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx){
      double bottom = MediaQuery.of(context).viewInsets.bottom;
      if(bottom > 0){
        if(widget.enable){
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
            _onKeyboardShowing();
          });
        }
      }else if(bottom == 0){
        _subscription?.cancel();
      }
      return widget.child;
    });
  }
}

