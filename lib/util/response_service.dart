import 'package:supabase_functions/supabase_functions.dart';

class ResponseService {
  static Response success(dynamic data) {
    return Response.json({"data": data});
  }

  static Response badRequest(dynamic data) {
    return Response.json({"msg": data}, status: 400);
  }

  static Response error(dynamic data) {
    return Response({"error_msg": data}, status: 500);
  }
}
