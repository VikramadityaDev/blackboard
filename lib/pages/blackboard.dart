import 'package:canvas/pages/about.dart';
import 'package:canvas/widgets/canvas.dart';
import 'package:canvas/model/draw_point.dart';
import 'package:flutter/material.dart';

class Blackboard extends StatefulWidget {
  const Blackboard({Key? key}) : super(key: key);
  @override
  State<Blackboard> createState() => _BlackboardState();
}
class _BlackboardState extends State<Blackboard> {
  final List<List<DrawPoint>> points = [];
  final List<List<DrawPoint>> pointsUndo = [];
  void _onGesture(Offset offset, [bool addNew = false]) => setState(() {
    if (addNew) {
      points.add([]);
    }
    points.last.add(DrawPoint(point: offset, color: Colors.white, thickness: 4.0));
  });
  void _onClear() => setState(() {
    pointsUndo.clear();
    pointsUndo.addAll(points);
    points.clear();
  });
  void _onUndo() => setState(() {
    if (points.isNotEmpty) {
      final lastDraw = points.last;
      pointsUndo.add(lastDraw);
      points.removeLast();
    }
  });
  void _onRedo() => setState(() {
    if (pointsUndo.isNotEmpty) {
      final lastDraw = pointsUndo.last;
      points.add(lastDraw);
      pointsUndo.removeLast();
    }
  });
  bool get canClear => points.isNotEmpty;
  bool get canUndo => points.isNotEmpty;
  bool get canRedo => pointsUndo.isNotEmpty;

  static const Color _lightColor = Color(0xFFECEFF1);
  static const Color _darkColor = Color.fromARGB(255, 28, 30, 31);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkColor,
      appBar: AppBar(
        title: RichText(
          textDirection: TextDirection.ltr,
            textAlign: TextAlign.end,
            text: const TextSpan(
              text: 'Black',
                style: TextStyle(fontSize: 20),
              children: [
                TextSpan(
                text: 'Board',
                style: TextStyle(fontSize: 20, color: Colors.amber),
                ),
                // WidgetSpan(
                //     alignment: PlaceholderAlignment.baseline,
                //     baseline: TextBaseline.alphabetic,
                //     child: SizedBox(width: 90)),
                // TextSpan(
                //   text: '@flutter.code.ninja',
                //   style: TextStyle(fontSize: 15, color: Colors.grey),
                // ),
              ]
            )
        ),
        foregroundColor: _lightColor,
        backgroundColor: _darkColor.withOpacity(0.75),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onPanStart: (details) => _onGesture(details.localPosition, true),
        onPanUpdate: (details) => _onGesture(details.localPosition),
        child: CustomPaint(
          painter: CanvasView(points: points),
          size: Size.infinite,
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          onPressed: _onUndo,
          backgroundColor: _lightColor,
          foregroundColor: _darkColor,
          child: const Icon(Icons.undo_outlined),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed:_onRedo,
          backgroundColor: _lightColor,
          foregroundColor: _darkColor,
          child: const Icon(Icons.redo_outlined),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _onClear,
          backgroundColor: _lightColor,
          foregroundColor: _darkColor,
          child: const Icon(Icons.clear),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          backgroundColor: _lightColor,
          foregroundColor: _darkColor,
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }
}