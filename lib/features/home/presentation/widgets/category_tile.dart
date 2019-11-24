import 'package:flutter/material.dart';
import 'package:ieee_mvp/features/home/domain/entities/category.dart';
import 'package:meta/meta.dart';

const _rowHeight = 50.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class CategoryTile extends StatelessWidget {
  final color = const ColorSwatch(0xFF2196F3, {
    'highlight': Color(0xFFBBDEFB),
    'splash': Color(0xFF2196F3),
  });

  final Category category;
  final ValueChanged<Category> onTap;

  const CategoryTile({
    Key key,
    @required this.category,
    this.onTap,
  })  : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
      onTap == null ? Color.fromRGBO(50, 50, 50, 0.2) : Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color['highlight'],
          splashColor: color['splash'],
          onTap: onTap == null ? null : () => onTap(category),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              category.name,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ),
      ),
    );
  }
}
