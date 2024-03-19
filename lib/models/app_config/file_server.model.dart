class FileServer {
  static const String urlKey = "url";

  FileServer({
    required this.url,
  });

  final String url;

  factory FileServer.fromMap(Map<String, dynamic> json) => FileServer(
        url: json[FileServer.urlKey],
      );
}
