# Cat App

## 1. Overview

A sample application for fetching and displaying data from a backend, structured in the MVC (Model-View-Controller) pattern for maintainability and expandability. The application is designed to be configurable.

![screenshot](https://i.ibb.co/TWy3Xdq/a.jpg)

## 2. Architecutre

### Models
the data model is cat model its main attributes:

* id
* url
* width
* height

To make the data model independent from the JSON format of the received data across the project, a new class called CatModel will be populated by the JSON object in a single place. This approach ensures that other parts of the code use the class directly, enhancing maintainability and consistency.

```dart
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
}
```

### Services

This project includes a single service called API_Service, responsible for communication between the application and the API. Currently, the service only implements GET requests.

To avoid duplication across methods performing GET requests, the logic for GET requests with error handling is encapsulated in the method:

```dart
Future _getRequest({ String query = "" }) async { 
```

This method is called by any method that performs a GET request, such as:

```dart
Future<List<CatModel>> getCats() {
```

### Controller
The CatsController is responsible for fetching data from the API service and manipulating it. Currently, it provides the cats data to the view.

### View

The view calls the provider to get the cats data and uses `MasonryGridView` and `CachedNetworkImage` to display images similar to Pinterest