class TravelItemModel {
  int? totalCount;
  List<TravelItem>? resultList;

  TravelItemModel({this.totalCount, this.resultList});

  TravelItemModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = <TravelItem>[];
      json['resultList'].forEach((v) {
        resultList!.add(TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (resultList != null) {
      data['resultList'] = resultList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelItem {
  int? type;
  Article? article;
  Advert? advert;
  Poi? poi;

  TravelItem({this.type, this.article, this.advert, this.poi});

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
        json['article'] != null ? Article.fromJson(json['article']) : null;
    advert = json['advert'] != null ? Advert.fromJson(json['advert']) : null;
    poi = json['poi'] != null ? Poi.fromJson(json['poi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (article != null) {
      data['article'] = article!.toJson();
    }
    if (advert != null) {
      data['advert'] = advert!.toJson();
    }
    if (poi != null) {
      data['poi'] = poi!.toJson();
    }
    return data;
  }
}

class Article {
  int? articleId;
  String? articleType;
  int? productType;
  int? sourceType;
  String? articleTitle;
  Author? author;
  List<Images>? images;
  bool? hasVideo;
  int? readCount;
  int? likeCount;
  int? commentCount;
  List<Urls>? urls;
  List<Tags>? tags;
  List<Topics>? topics;
  List<Pois>? pois;
  String? publishTime;
  String? publishTimeDisplay;
  String? shootTime;
  String? shootTimeDisplay;
  int? level;
  String? distanceText;
  bool? isLike;
  int? imageCounts;
  bool? isCollected;
  int? collectCount;
  int? articleStatus;
  String? poiName;
  String? articleDesc;
  String? sourceInfo;

  Article(
      {this.articleId,
      this.articleType,
      this.productType,
      this.sourceType,
      this.articleTitle,
      this.author,
      this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.urls,
      this.tags,
      this.topics,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.level,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName,
      this.articleDesc,
      this.sourceInfo});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    articleType = json['articleType'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(Urls.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = <Pois>[];
      json['pois'].forEach((v) {
        pois!.add(Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
    articleDesc = json['articleDesc'];
    sourceInfo = json['sourceInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['articleId'] = articleId;
    data['articleType'] = articleType;
    data['productType'] = productType;
    data['sourceType'] = sourceType;
    data['articleTitle'] = articleTitle;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = hasVideo;
    data['readCount'] = readCount;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (pois != null) {
      data['pois'] = pois!.map((v) => v.toJson()).toList();
    }
    data['publishTime'] = publishTime;
    data['publishTimeDisplay'] = publishTimeDisplay;
    data['shootTime'] = shootTime;
    data['shootTimeDisplay'] = shootTimeDisplay;
    data['level'] = level;
    data['distanceText'] = distanceText;
    data['isLike'] = isLike;
    data['imageCounts'] = imageCounts;
    data['isCollected'] = isCollected;
    data['collectCount'] = collectCount;
    data['articleStatus'] = articleStatus;
    data['poiName'] = poiName;
    data['articleDesc'] = articleDesc;
    data['sourceInfo'] = sourceInfo;
    return data;
  }
}

class Author {
  int? authorId;
  String? nickName;
  String? clientAuth;
  String? jumpUrl;
  CoverImage? coverImage;
  int? identityType;
  String? tag;
  String? qualification;

  Author(
      {this.authorId,
      this.nickName,
      this.clientAuth,
      this.jumpUrl,
      this.coverImage,
      this.identityType,
      this.tag,
      this.qualification});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? CoverImage.fromJson(json['coverImage'])
        : null;
    identityType = json['identityType'];
    tag = json['tag'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorId'] = authorId;
    data['nickName'] = nickName;
    data['clientAuth'] = clientAuth;
    data['jumpUrl'] = jumpUrl;
    if (coverImage != null) {
      data['coverImage'] = coverImage!.toJson();
    }
    data['identityType'] = identityType;
    data['tag'] = tag;
    data['qualification'] = qualification;
    return data;
  }
}

class CoverImage {
  String? dynamicUrl;
  String? originalUrl;

  CoverImage({this.dynamicUrl, this.originalUrl});

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    return data;
  }
}

class Images {
  int? imageId;
  String? dynamicUrl;
  String? originalUrl;
  double? width;
  double? height;
  int? mediaType;
  bool? isWaterMarked;

  Images(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height,
      this.mediaType,
      this.isWaterMarked});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    data['width'] = width;
    data['height'] = height;
    data['mediaType'] = mediaType;
    data['isWaterMarked'] = isWaterMarked;
    return data;
  }
}

class Urls {
  String? version;
  String? appUrl;
  String? h5Url;
  String? wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    return data;
  }
}

class Tags {
  int? tagId;
  String? tagName;
  int? tagLevel;
  int? parentTagId;
  int? source;
  int? sortIndex;

  Tags(
      {this.tagId,
      this.tagName,
      this.tagLevel,
      this.parentTagId,
      this.source,
      this.sortIndex});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    tagName = json['tagName'];
    tagLevel = json['tagLevel'];
    parentTagId = json['parentTagId'];
    source = json['source'];
    sortIndex = json['sortIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tagId'] = tagId;
    data['tagName'] = tagName;
    data['tagLevel'] = tagLevel;
    data['parentTagId'] = parentTagId;
    data['source'] = source;
    data['sortIndex'] = sortIndex;
    return data;
  }
}

class Topics {
  int? topicId;
  String? topicName;
  int? level;
  IconImage? iconImage;

  Topics({this.topicId, this.topicName, this.level, this.iconImage});

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
    iconImage = json['iconImage'] != null
        ? IconImage.fromJson(json['iconImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    data['level'] = level;
    if (iconImage != null) {
      data['iconImage'] = iconImage!.toJson();
    }
    return data;
  }
}

class IconImage {
  int? imageId;
  String? dynamicUrl;
  String? originalUrl;
  int? width;
  int? height;
  int? mediaType;

  IconImage(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height,
      this.mediaType});

  IconImage.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['dynamicUrl'] = dynamicUrl;
    data['originalUrl'] = originalUrl;
    data['width'] = width;
    data['height'] = height;
    data['mediaType'] = mediaType;
    return data;
  }
}

class Pois {
  int? poiType;
  int? poiId;
  String? poiName;
  int? businessId;
  int? districtId;
  PoiExt? poiExt;
  int? source;
  int? isMain;
  bool? isInChina;
  String? countryName;
  String? districtName;
  String? districtENName;

  Pois(
      {this.poiType,
      this.poiId,
      this.poiName,
      this.businessId,
      this.districtId,
      this.poiExt,
      this.source,
      this.isMain,
      this.isInChina,
      this.countryName,
      this.districtName,
      this.districtENName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt = json['poiExt'] != null ? PoiExt.fromJson(json['poiExt']) : null;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    countryName = json['countryName'];
    districtName = json['districtName'];
    districtENName = json['districtENName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['businessId'] = businessId;
    data['districtId'] = districtId;
    if (poiExt != null) {
      data['poiExt'] = poiExt!.toJson();
    }
    data['source'] = source;
    data['isMain'] = isMain;
    data['isInChina'] = isInChina;
    data['countryName'] = countryName;
    data['districtName'] = districtName;
    data['districtENName'] = districtENName;
    return data;
  }
}

class PoiExt {
  String? h5Url;
  String? appUrl;

  PoiExt({this.h5Url, this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}

class Advert {
  int? id;
  int? moduleId;
  String? appUrl;
  String? h5Url;
  String? wxUrl;
  String? imageUrl;
  int? width;
  int? height;

  Advert(
      {this.id,
      this.moduleId,
      this.appUrl,
      this.h5Url,
      this.wxUrl,
      this.imageUrl,
      this.width,
      this.height});

  Advert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['moduleId'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
    imageUrl = json['imageUrl'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['moduleId'] = moduleId;
    data['appUrl'] = appUrl;
    data['h5Url'] = h5Url;
    data['wxUrl'] = wxUrl;
    data['imageUrl'] = imageUrl;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Poi {
  int? poiType;
  int? poiId;
  String? poiName;
  int? hotValue;
  Article? article;
  String? distanceText;
  int? tripShootCount;
  String? shortFeature;
  String? h5Url;
  String? appUrl;

  Poi(
      {this.poiType,
      this.poiId,
      this.poiName,
      this.hotValue,
      this.article,
      this.distanceText,
      this.tripShootCount,
      this.shortFeature,
      this.h5Url,
      this.appUrl});

  Poi.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    hotValue = json['hotValue'];
    article =
        json['article'] != null ? Article.fromJson(json['article']) : null;
    distanceText = json['distanceText'];
    tripShootCount = json['tripShootCount'];
    shortFeature = json['shortFeature'];
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poiType'] = poiType;
    data['poiId'] = poiId;
    data['poiName'] = poiName;
    data['hotValue'] = hotValue;
    if (article != null) {
      data['article'] = article!.toJson();
    }
    data['distanceText'] = distanceText;
    data['tripShootCount'] = tripShootCount;
    data['shortFeature'] = shortFeature;
    data['h5Url'] = h5Url;
    data['appUrl'] = appUrl;
    return data;
  }
}
