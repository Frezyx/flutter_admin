import 'package:flutter/widgets.dart';

/// Observes the window changes and provides a [MediaQuery]
/// always up to date.
class MediaQueryIjector extends StatefulWidget {
  final Widget child;

  const MediaQueryIjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MediaQueryIjector> createState() => _MediaQueryIjectorState();
}

class _MediaQueryIjectorState extends State<MediaQueryIjector>
    with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    setState(() {});
    super.didChangeMetrics();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: widget.child,
    );
  }
}
