import 'package:supabase_edge_functions_example/contant/app_state.dart';
import 'package:supabase_functions/supabase_functions.dart';

import 'controller/park_controller.dart';
import 'model/request.dart';

void main() {
  AppState.serviceRole = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  AppState.supabaseUrl = Deno.env.get("SUPABASE_URL");
  ParkController parkController = ParkController();
  SupabaseFunctions(fetch: (request) async {
    print("Value:-- ${request.url}");
    RequestModel requestModel =
        RequestModel.convertJsonToModel(await request.json());
    print("Model:  ${requestModel.toJson()}");
    return await parkController.processParkRequest(requestModel);
  });
}
