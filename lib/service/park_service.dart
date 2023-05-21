import 'dart:developer';

import 'package:supabase_edge_functions_example/dbService/db_service.dart';
import 'package:supabase_edge_functions_example/model/ticket.dart';
import 'package:supabase_edge_functions_example/util/response_service.dart';
import 'package:uuid/uuid.dart';

class ParkService {
  DBService? _dbService;

  ParkService(DBService dbService) {
    _dbService = dbService;
  }

  dynamic getAllAmusementParkDetails() async {
    log("[_getAllAmusementParkDetails] Stated");
    return await _dbService!.getAllAmusementParkRecords();
  }

  dynamic getAmusementParkById(int? id) async {
    print("[_getAmusementParkById] Stated $id");
    if (id == null) {
      return ResponseService.badRequest("park id not found.");
    }
    return await _dbService!.getAmusementParkRecordById(id);
  }

  dynamic getAllAmusementParkByTypesAndRating(dynamic queryParams) async {
    print("[_getAllAmusementParkByTypesAndRating] $queryParams");

    if (queryParams == null) {
      return ResponseService.badRequest("No query params found.");
    }
    if (queryParams['rating'] == null) {
      return ResponseService.badRequest("Rating is not found.");
    }
    if (queryParams['types'] == null || queryParams['types'].length < 1) {
      return ResponseService.badRequest("Rating is not found.");
    }
    String orderBy = queryParams['order_by'] ?? "asc";
    double rating = queryParams['rating'];
    List<String> types = [];
    for (int i = 0; i < queryParams['types'].length; i++) {
      print("Loop:--- ${queryParams['types'][0]}");
      types.add(queryParams['types'][0]);
    }
    print("orderBy  $orderBy  rating  $rating  types $types");

    return await _dbService!
        .getAmusementRecordsByRatingAndTypesAndOrderBy(rating, types, orderBy);
  }

  dynamic createFairTicket(Ticket ticket) async {
    print("Ticket Reqeust:--  ${ticket.toJson()}");
    print("New Ticke Details");

    // if (ticket.standardCount! >= 0 && ticket.standardPrice == null ||
    //     ticket.standardPrice! >= 0 && ticket.standardCount == null) {
    //   return Response.json({"msg": "Invaild standard Ticket format."},
    //       status: 400);
    // }
    // if (ticket.expressCount! >= 0 && ticket.expressPrice == null ||
    //     ticket.expressPrice! >= 0 && ticket.expressCount == null) {
    //   return Response.json({"msg": "Invaild Express Ticket format."},
    //       status: 400);
    // }
    // if (ticket.vipCount! >= 0 && ticket.vipPrice == null ||
    //     ticket.vipPrice! >= 0 && ticket.vipCount == null) {
    //   return Response.json({"msg": "Invaild VIP Ticket format."}, status: 400);
    // }
    // if (ticket.userId == null || ticket.userId! < 1) {
    //   return Response.json({"msg": "Invaild User-Id Reference."}, status: 400);
    // }
    var uuid = Uuid();
    ticket.ticketRefId = uuid.v1();
    print("Ticket Ref Number ${ticket.ticketRefId}}");
    return await _dbService!.createAmusementParkTicketRecord(ticket);
  }

  dynamic getTicketHistoryByUserId(dynamic queryParms) async {
    if (queryParms == null) {
      return ResponseService.badRequest("No query params found.");
    }
    String? userId = queryParms['user_id'];
    print("[getTicketHistoryByUserId] Stated $userId");
    if (userId == null) {
      return ResponseService.badRequest("User id not found.");
    }
    return await _dbService!.getAllTicketRecordsByUserId(userId);
  }

  dynamic getUserFavList(dynamic queryParms) async {
    if (queryParms == null) {
      return ResponseService.badRequest("No query params found.");
    }
    int? id = queryParms['id'];
    print("[getUserFavList] Stated $id");
    if (id == null || id < 1) {
      return ResponseService.badRequest("Id not found.");
    }
    return await _dbService!.getAllUserFavList(id);
  }

  dynamic getUserDetailById(dynamic queryParms) async {
    print("getUserDetailById  $queryParms");
    if (queryParms == null) {
      return ResponseService.badRequest("No query params found.");
    }
    String? id = queryParms['id'];
    print("[getUserDetailById] UserId $id");
    if (id == null) {
      return ResponseService.badRequest("Id not found.");
    }
    return await _dbService!.getUserDetailById(id);
  }
}
