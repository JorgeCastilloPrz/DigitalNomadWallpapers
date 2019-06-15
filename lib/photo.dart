class Photo {
  final String url;
  final String photographer;
  final String original;
  final String large;
  final String large2x;
  final String medium;

  Photo._(
      {this.url,
      this.photographer,
      this.original,
      this.large,
      this.large2x,
      this.medium});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      url: json['url'],
      photographer: json['photographer'],
      original: json['src']['original'],
      large: json['src']['large'],
      large2x: json['src']['large2x'],
      medium: json['src']['medium'],
    );
  }
}
