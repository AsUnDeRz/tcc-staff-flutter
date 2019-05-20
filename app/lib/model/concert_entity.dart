import 'package:app/model/base_error_entity.dart';

class ConcertEntity {
  ConcertData data;
  BaseError error;

  ConcertEntity({this.data});

  ConcertEntity.fromJson(Map<String, dynamic> json) {
    try {
      data = json['data'] != null ? new ConcertData.fromJson(json['data']) : null;
      error = json['error'] != null ? new BaseError.fromJson(json['error']) : null;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  ConcertEntity.withError(String error) {
    this.error = BaseError.fromJson({
      "error": {"message": error}
    });
  }
}

class ConcertData {
  ConcertDataPagination pagination;
  List<ConcertDataRecord> record;

  ConcertData({this.pagination, this.record});

  ConcertData.fromJson(Map<String, dynamic> json) {
    pagination =
        json['pagination'] != null ? new ConcertDataPagination.fromJson(json['pagination']) : null;
    if (json['record'] != null) {
      record = new List<ConcertDataRecord>();
      (json['record'] as List).forEach((v) {
        record.add(new ConcertDataRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.record != null) {
      data['record'] = this.record.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConcertDataPagination {
  int total;
  int lastPage;
  int limit;
  int currentPage;

  ConcertDataPagination({this.total, this.lastPage, this.limit, this.currentPage});

  ConcertDataPagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['last_page'];
    limit = json['limit'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['last_page'] = this.lastPage;
    data['limit'] = this.limit;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class ConcertDataRecord {
  ConcertDataRecordVenue venue;
  List<ConcertDataRecordImage> images;
  String updatedAt;
  ConcertDataRecordShowtime showtime;
  int ticketCount;
  String name;
  String createdAt;
  int id;
  String type;
  bool status;

  ConcertDataRecord(
      {this.venue,
      this.images,
      this.updatedAt,
      this.showtime,
      this.ticketCount,
      this.name,
      this.createdAt,
      this.id,
      this.type,
      this.status});

  ConcertDataRecord.fromJson(Map<String, dynamic> json) {
    venue = json['venue'] != null ? new ConcertDataRecordVenue.fromJson(json['venue']) : null;
    if (json['images'] != null) {
      images = new List<ConcertDataRecordImage>();
      (json['images'] as List).forEach((v) {
        images.add(new ConcertDataRecordImage.fromJson(v));
      });
    }
    updatedAt = json['updated_at'];
    showtime =
        json['showtime'] != null ? new ConcertDataRecordShowtime.fromJson(json['showtime']) : null;
    ticketCount = json['ticket_count'];
    name = json['name'];
    createdAt = json['created_at'];
    id = json['id'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['updated_at'] = this.updatedAt;
    if (this.showtime != null) {
      data['showtime'] = this.showtime.toJson();
    }
    data['ticket_count'] = this.ticketCount;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}

class ConcertDataRecordVenue {
  String address;
  String name;
  int id;
  double lat;
  double long;

  ConcertDataRecordVenue({this.address, this.name, this.id, this.lat, this.long});

  ConcertDataRecordVenue.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class ConcertDataRecordImage {
  int storeId;
  int size;
  String mime;
  String name;
  int width;
  int albumId;
  String id;
  String tag;
  String url;
  int height;

  ConcertDataRecordImage(
      {this.storeId,
      this.size,
      this.mime,
      this.name,
      this.width,
      this.albumId,
      this.id,
      this.tag,
      this.url,
      this.height});

  ConcertDataRecordImage.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    size = json['size'];
    mime = json['mime'];
    name = json['name'];
    width = json['width'];
    albumId = json['album_id'];
    id = json['id'];
    tag = json['tag'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['size'] = this.size;
    data['mime'] = this.mime;
    data['name'] = this.name;
    data['width'] = this.width;
    data['album_id'] = this.albumId;
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class ConcertDataRecordShowtime {
  String textFull;
  String textShort;
  String start;
  String end;
  String statusText;
  int status;

  ConcertDataRecordShowtime(
      {this.textFull, this.textShort, this.start, this.end, this.statusText, this.status});

  ConcertDataRecordShowtime.fromJson(Map<String, dynamic> json) {
    textFull = json['text_full'];
    textShort = json['text_short'];
    start = json['start'];
    end = json['end'];
    statusText = json['status_text'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text_full'] = this.textFull;
    data['text_short'] = this.textShort;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status_text'] = this.statusText;
    data['status'] = this.status;
    return data;
  }
}
