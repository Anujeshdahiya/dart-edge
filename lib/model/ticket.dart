import 'dart:collection';

class Ticket {
  int? standardCount;
  int? expressCount;
  int? vipCount;
  int? standardPrice;
  int? expressPrice;
  int? vipPrice;
  String? userId;
  String? ticketRefId;

  Ticket(
      {this.standardCount,
      this.expressCount,
      this.vipCount,
      this.standardPrice,
      this.expressPrice,
      this.vipPrice,
      this.userId,
      this.ticketRefId});

  Ticket.fromJson(Map<String, dynamic> json) {
    standardCount = json['standard_count'];
    expressCount = json['express_count'];
    vipCount = json['vip_count'];
    standardPrice = json['standard_price'];
    expressPrice = json['express_price'];
    vipPrice = json['vip_price'];
    userId = json['user_id'];
    ticketRefId = json['ticket_ref_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = HashMap<String, dynamic>();
    data['standard_count'] = standardCount;
    data['express_count'] = expressCount;
    data['vip_count'] = vipCount;
    data['standard_price'] = standardPrice;
    data['express_price'] = expressPrice;
    data['vip_price'] = vipPrice;
    data['user_id'] = userId;
    data['ticket_ref_id'] = ticketRefId;
    return data;
  }
}
