import 'dart:math';

import 'package:supabase/supabase.dart';
import 'package:edge_http_client/edge_http_client.dart';
import 'package:supabase_edge_functions_example/model/ticket.dart';
import 'package:supabase_edge_functions_example/util/response_service.dart';

class DBService {
  SupabaseClient? _supabaseClient;

  DBService(String supaBaseURL, String key) {
    _supabaseClient =
        SupabaseClient(supaBaseURL, key, httpClient: EdgeHttpClient());
  }

  SupabaseClient getClient() {
    return _supabaseClient!;
  }

  dynamic getAllAmusementParkRecords() async {
    try {
      return ResponseService.success(
          await _supabaseClient!.from('amusement_park').select());
    } catch (e) {
      return ResponseService.error(e.toString());
    }
  }

  dynamic getAmusementParkRecordById(dynamic id) async {
    print("getAmusementParkRecordById [Start]");
    dynamic response = await _supabaseClient!
        .from('amusement_park')
        .select()
        .eq('id', id)
        .onError((error, stackTrace) {
      print("[getAmusementParkRecordById] $e");
      return ResponseService.error(e.toString());
    });

    return ResponseService.success(response);
  }

  dynamic getAmusementRecordsByRatingAndTypesAndOrderBy(
      double rating, List<String> types, String orderBy) async {
    dynamic response = await _supabaseClient!
        .from('amusement_park')
        .select()
        .gt('rating', rating)
        .contains('types', types)
        .order('created_at', ascending: orderBy == "asc")
        .onError((error, stackTrace) {
      return ResponseService.error(error.toString());
    });

    return ResponseService.success(response);
  }

  dynamic createAmusementParkTicketRecord(dynamic ticket) async {
    Ticket value = ticket;
    print("Final Value--- ${value.toJson()}");
    print("Before Calling DB call");
    dynamic response = await _supabaseClient!
        .from('tickets')
        .insert(ticket)
        .select()
        .onError((error, stackTrace) {
      return ResponseService.error(error.toString());
    });
    return ResponseService.success(response);
  }

  dynamic getAllTicketRecordsByUserId(String userId) async {
    print("getAllTicketRecordsByUserId :- $userId");
    dynamic response = await _supabaseClient!
        .from('tickets')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .onError((error, stackTrace) {
      return ResponseService.error(error.toString());
    });
    return ResponseService.success(response);
  }

  dynamic getAllUserFavList(int userId) async {
    print("getAllUserFavList $userId");
    dynamic response = await _supabaseClient!
        .from('users')
        .select()
        .eq('id', userId)
        .onError((error, stackTrace) {
      ResponseService.error(error.toString());
    });
    return ResponseService.success(response);
  }

  dynamic getUserDetailById(String userId) async {
    print("getUserDetailById $userId");
    dynamic response = await _supabaseClient!
        .from('users')
        .select()
        .eq('id', userId)
        .onError((error, stackTrace) {
      ResponseService.error(error.toString());
    });
    return ResponseService.success(response);
  }
}
