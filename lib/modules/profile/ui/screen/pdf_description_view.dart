import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfDescriptionView extends StatefulWidget {
  final String assetPath;
  const PdfDescriptionView({super.key, required this.assetPath});

  @override
  State<PdfDescriptionView> createState() => _PdfDescriptionViewState();
}

class _PdfDescriptionViewState extends State<PdfDescriptionView> {
  late final PdfController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfController(
      document: PdfDocument.openAsset(widget.assetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body:SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return PdfView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              renderer: (PdfPage page) => page.render(
                width: constraints.maxWidth,     // Forces natural width
                height: constraints.maxHeight,   // Forces natural height
                quality: 100,
              ),
            );
          }
        ),
      )
    );
  }
}
