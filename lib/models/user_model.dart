import 'package:first_store_nodejs_flutter/models/product_mobile.dart';

class UserModel {
    String? id;
    String? name;
    String? email;
    ProfilePicture? profilePicture;
    bool? isAdmin;
    bool? isVerified;
    bool? trustedUser;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? bio;
    List<ProductMobile>? products;
   String? token;
  

    UserModel({
        this.id,
        this.name,
        this.email,
        this.profilePicture,
        this.isAdmin,
        this.isVerified,
        this.trustedUser,
        this.createdAt,
        this.updatedAt,
        this.bio,
        this.products,
        this.token,

    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] ?? "",
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        profilePicture: ProfilePicture.fromJson(json['profilePicture'] ?? {}),
        isAdmin: json['isAdmin'] ?? false,
        isVerified: json['isVerified'] ?? false,
        trustedUser: json['trustedUser'] ?? false,
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String() ),
        updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String() ),
        bio: json['bio'] ?? "",
        products: json['products'] == null 
              ? [] 
              : List<ProductMobile>.from(json['products'].map((x) => ProductMobile.fromJson(x))),
        token: json['token'] ?? "",
        
    );

    Map<String, dynamic> toJson() => {

        "_id": id,
        "name": name,
        "email": email,
        "profilePicture": profilePicture!.toJson(),
        "isAdmin": isAdmin,
        "isVerified": isVerified,
        "trustedUser": trustedUser,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "bio": bio,
        "products": List<ProductMobile>.from(products!.map((x) => x.toJson())  ),
        "token": token,

        
    };

  



}

class ProfilePicture {
    String? url;
    String? publicId;

    ProfilePicture({
        this.url,
        this.publicId,
    });

    factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
        url: json['url'] ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
        publicId: json['publicId'] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
    };



}
