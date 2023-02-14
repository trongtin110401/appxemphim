class Movie {
  String? message;
  List<Data>? data;

  Movie({this.message, this.data});

  Movie.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? idmovie;
  String? name;
  String? img;
  String? url;
  int? idcategory;

  Data({this.idmovie, this.name, this.img, this.url, this.idcategory});

  Data.fromJson(Map<String, dynamic> json) {
    idmovie = json['idmovie'];
    name = json['name'];
    img = json['img'];
    url = json['url'];
    idcategory = json['idcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idmovie'] = this.idmovie;
    data['name'] = this.name;
    data['img'] = this.img;
    data['url'] = this.url;
    data['idcategory'] = this.idcategory;
    return data;
  }
}