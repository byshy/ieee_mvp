import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Category extends Equatable {
  final String name;

  const Category({
    @required this.name,
  })  : assert(name != null);

  @override
  List<Object> get props => [name];
}