import 'package:supabase_edge_functions_example/dbService/db_service_singleton.dart';
import 'package:supabase_edge_functions_example/model/ticket.dart';

import '../model/request.dart';
import '../service/park_service.dart';

class ParkController {
  dynamic processParkRequest(RequestModel requestModel) async {
    if (requestModel.methodType == "GET") {
      return await _processGetRequest(requestModel);
    } else if (requestModel.methodType == "POST") {
      return await _processPostRequest(requestModel);
    }
  }

  dynamic _processGetRequest(RequestModel requestModel) async {
    ParkService parkService = ParkService(DBServiceSingleton.getDBInstance());
    String method = requestModel.methodUrl!;
    if (method == "get_all_amusement_park_details") {
      return await parkService.getAllAmusementParkDetails();
    } else if (method == "get_amusement_park_by_id") {
      print("[Query Param] ${requestModel.queryParams}");
      return await parkService
          .getAmusementParkById(requestModel.queryParams['id']);
    } else if (method == "get_all_amusement_park_by_type_rating") {
      return await parkService
          .getAllAmusementParkByTypesAndRating(requestModel.queryParams);
    } else if (method == "get_ticket_history") {
      return await parkService
          .getTicketHistoryByUserId(requestModel.queryParams);
    } else if (method == "get_all_fav_users") {
      return await parkService.getUserFavList(requestModel.queryParams);
    } else if (method == "get_user_detail_by_id") {
      return await parkService.getUserDetailById(requestModel.queryParams);
    }
  }

  dynamic _processPostRequest(RequestModel requestModel) async {
    print("Received Reqeust:-- $requestModel");
    ParkService parkService = ParkService(DBServiceSingleton.getDBInstance());
    if (requestModel.methodUrl == "create_fair_ticket") {
      Ticket ticket = Ticket.fromJson(requestModel.data);
      print("Converted Model :-- $ticket ");
      return await parkService.createFairTicket(ticket);
    }
    return null;
  }
}
