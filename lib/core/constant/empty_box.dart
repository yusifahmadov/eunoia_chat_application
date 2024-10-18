import 'package:flutter/material.dart';

class EmptyHeightBox extends SizedBox {
  @override
  final double? height;
  const EmptyHeightBox({super.key, this.height = 20}) : super(height: height);
}

class EmptyWidthBox extends SizedBox {
  @override
  final double? width;
  const EmptyWidthBox({super.key, this.width = 20}) : super(width: width);
}
