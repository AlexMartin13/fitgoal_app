import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitgoal_app/widgets/appbar.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<DrawnLine> lines = [];
  DrawnLine? line;
  Color selectedColor = Colors.black;
  bool showFABOptions = false;
  ui.Image? backgroundImage;
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _loadDefaultBackgroundImage();
  }

  Future<void> _loadDefaultBackgroundImage() async {
    final ByteData data = await rootBundle.load('assets/png_icons/pitch.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      backgroundImage = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reducedAppBar(context, 'home'),
      backgroundColor: const Color.fromRGBO(1, 49, 45, 1),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                line = DrawnLine([details.localPosition], selectedColor);
              });
            },
            onPanUpdate: (details) {
              setState(() {
                line = DrawnLine([...line!.points, details.localPosition], selectedColor);
              });
            },
            onPanEnd: (details) {
              setState(() {
                lines.add(line!);
                line = null;
              });
            },
            child: RepaintBoundary(
              key: _globalKey,
              child: CustomPaint(
                painter: BoardPainter(lines: lines, currentLine: line, backgroundImage: backgroundImage),
                size: Size.infinite,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showFABOptions) ...[
                  FloatingActionButton(
                    heroTag: 'save',
                    onPressed: _saveToFile,
                    child: Icon(Icons.save),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    heroTag: 'pickImage',
                    onPressed: () async {
                      final ui.Image? newImage = await _pickBackgroundImage();
                      if (newImage != null) {
                        setState(() {
                          backgroundImage = newImage;
                        });
                      }
                    },
                    child: Icon(Icons.image),
                  ),
                  SizedBox(height: 10),
                ],
                FloatingActionButton(
                  heroTag: 'menu',
                  onPressed: () {
                    setState(() {
                      showFABOptions = !showFABOptions;
                    });
                  },
                  child: Icon(showFABOptions ? Icons.close : Icons.menu),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                _colorButton(Colors.black),
                _colorButton(Colors.red),
                _colorButton(Colors.green),
                _colorButton(Colors.blue),
                _colorButton(Colors.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  Future<void> _saveToFile() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final path = '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(pngBytes);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved to ${file.path}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving file: $e')));
    }
  }

  Future<ui.Image?> _pickBackgroundImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      return frame.image;
    }
    return null;
  }

  Future<void> _requestPermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    var externalStatus = await Permission.manageExternalStorage.status;
    if (!externalStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }
}

class DrawnLine {
  final List<Offset> points;
  final Color color;

  DrawnLine(this.points, this.color);
}

class BoardPainter extends CustomPainter {
  final List<DrawnLine> lines;
  final DrawnLine? currentLine;
  final ui.Image? backgroundImage;

  BoardPainter({required this.lines, this.currentLine, this.backgroundImage});

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        image: backgroundImage!,
        fit: BoxFit.cover,
      );
    }

    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var line in lines) {
      paint.color = line.color;
      for (int i = 0; i < line.points.length - 1; i++) {
        if (line.points[i] != null && line.points[i + 1] != null) {
          canvas.drawLine(line.points[i], line.points[i + 1], paint);
        }
      }
    }

    if (currentLine != null) {
      paint.color = currentLine!.color;
      for (int i = 0; i < currentLine!.points.length - 1; i++) {
        if (currentLine!.points[i] != null && currentLine!.points[i + 1] != null) {
          canvas.drawLine(currentLine!.points[i], currentLine!.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
