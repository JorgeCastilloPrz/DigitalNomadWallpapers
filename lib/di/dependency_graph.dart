import 'package:digital_nomad_wallpapers/data/PhotosRepository.dart';
import 'package:flutter/foundation.dart';

@immutable
class DependencyGraph {
  final PhotosRepository photosRepo;

  const DependencyGraph({this.photosRepo});
}
