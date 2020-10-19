import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import '../models/story.dart';

class VimeoIframeScreen extends StatefulWidget {
  const VimeoIframeScreen({Key key, this.story}) : super(key: key);
  final Story story;

  @override
  _VimeoIframeScreenState createState() => _VimeoIframeScreenState();
}

class _VimeoIframeScreenState extends State<VimeoIframeScreen> {
  Widget _iframeWidget;

  final IFrameElement _iframeElement = IFrameElement();
  String html;

  @override
  void initState() {
    super.initState();

    // _iframeElement.height = '500';
    // _iframeElement.width = '500';
    _iframeElement.src = 'https://player.vimeo.com/video/${widget.story.id}?app_id=122963';
    _iframeElement.style.border = 'none';
    _iframeElement.allow = 'autoplay; fullscreen';
    _iframeElement.allowFullscreen;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.story.title)),
      body: Center(
        child: Expanded(
          child: _iframeWidget,
        ),
      ),
    );
  }
}
