class CatModel {
  String? id;
  String? url;
  double? width;
  double? height;

  CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  // Factory method to create an instance from JSON
  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      url: json['url'],
      width: json['width'] * 1.0,
      height: json['height'] *1.0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'width': width,
      'height': height,
    };
  }
  bool isAllMembersAreNotNull (){
    return id != null &&  url != null && width != null && height != null ;
  }
}
