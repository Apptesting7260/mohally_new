class ArabicSeachModel {
  ArabicSeachModel({
     this.status,
     this.products,
  });
   bool ?status;
   List<Products> ?products;

  ArabicSeachModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['products'] = products!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Products {
  Products({
     this.id,
     this.productType,
     this.aTitle,
     this.price,
     this.mainCategoryId,
     this.averageRating,
     this.imageUrl,
    this.galleryUrl,
  });
var id;
 var productType;
 var aTitle;
 var price;
 var mainCategoryId;
var averageRating;
 var imageUrl;
 var galleryUrl;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    aTitle = json['a_title'];
    price = json['price'];
    mainCategoryId = json['main_category_id'];
    averageRating = json['average_rating'];
    imageUrl = json['image_url'];
    galleryUrl = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_type'] = productType;
    _data['a_title'] = aTitle;
    _data['price'] = price;
    _data['main_category_id'] = mainCategoryId;
    _data['average_rating'] = averageRating;
    _data['image_url'] = imageUrl;
    _data['gallery_url'] = galleryUrl;
    return _data;
  }
}
