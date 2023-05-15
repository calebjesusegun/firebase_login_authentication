class PushNotificationModel {
  int? multicastId;
  int? success;
  int? failure;
  int? canonicalIds;
  List<Results>? results;

  PushNotificationModel(
      {this.multicastId,
      this.success,
      this.failure,
      this.canonicalIds,
      this.results});

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    multicastId = json['multicast_id'];
    success = json['success'];
    failure = json['failure'];
    canonicalIds = json['canonical_ids'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['multicast_id'] = multicastId;
    data['success'] = success;
    data['failure'] = failure;
    data['canonical_ids'] = canonicalIds;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? messageId;

  Results({this.messageId});

  Results.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    return data;
  }
}
