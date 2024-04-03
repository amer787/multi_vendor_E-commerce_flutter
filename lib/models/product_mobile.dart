class ProductMobile {
    String? id;
    String? deviceType;
    String? brand;
    String? modelDevice;
    String? capacity;
    String? color;
    int? batteryHealth;
    int? price;
    List<ProductPicture>? productPictures;
    List<dynamic>? favoriteProduct;
    bool? isFeatured;
    CreatedBy? createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? description;

    ProductMobile({
        this.id,
        this.deviceType,
        this.brand,
        this.modelDevice,
        this.capacity,
        this.color,
        this.batteryHealth,
        this.price,
        this.productPictures,
        this.favoriteProduct,
        this.isFeatured,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.description,
    });

 factory ProductMobile.fromJson(Map<String, dynamic> json) {
  // Check if 'createdBy' is a Map (detailed user information is provided)
  var createdByValue = json["createdBy"];
  CreatedBy? createdBy;
  if (createdByValue is Map<String, dynamic>) {
    createdBy = CreatedBy.fromJson(createdByValue);
  } else if (createdByValue is String) {
    // Assuming 'createdBy' is a String (only user ID is provided), initialize with minimal data
    createdBy = CreatedBy(id: createdByValue);
  }

  return ProductMobile(
    id: json["_id"],
    deviceType: json["deviceType"],
    brand: json["brand"],
    modelDevice: json["modelDevice"],
    capacity: json["capacity"],
    color: json["color"],
    batteryHealth: json["batteryHealth"],
    price: json["price"],
    productPictures: List<ProductPicture>.from(json["productPictures"].map((x) => ProductPicture.fromJson(x)) ?? []),
    favoriteProduct: List<dynamic>.from(json["favoriteProduct"] ?? []),
    isFeatured: json["isFeatured"] ?? false,
    createdBy: createdBy,
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    description: json["description"] ?? '',
  );
}

     Map<String, dynamic> toJson() => {
       
        "deviceType": deviceType,
        "brand": brand,
        "modelDevice": modelDevice,
        "capacity": capacity,
        "color": color,
        "batteryHealth": batteryHealth,
        "price": price,
        "productPictures": List<dynamic>.from(productPictures!.map((x) => x.toJson())),
        "favoriteProduct": List<dynamic>.from(favoriteProduct!.map((x) => x)),
        "isFeatured": isFeatured,
        "createdBy": createdBy!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "description": description,
    };

}



class CreatedBy {
    String? id;
    String? name;
    String? email;
    String? createdById;

    CreatedBy({
        this.id,
        this.name,
        this.email,
        this.createdById,
    });

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        createdById: json["createdById"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "createdById": createdById,
    };



}

class ProductPicture {
    Img? img;
    String? id;
    String? productPictureId;

    ProductPicture({
        this.img,
        this.id,
        this.productPictureId,
    });

    factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
        img: Img.fromJson(json["img"]),
        id: json["_id"],
        productPictureId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "img": img!.toJson(),
        "id": id,
        "productPictureId": productPictureId,
    };

}

class Img {
    String? url;
    String? publicId;

    Img({
        this.url,
        this.publicId,
    });

    factory Img.fromJson(Map<String, dynamic> json) => Img(
        url: json["url"],
        publicId: json["publicId"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
    };

}
