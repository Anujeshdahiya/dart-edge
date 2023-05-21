import 'package:supabase_edge_functions_example/contant/app_state.dart';
import 'package:supabase_edge_functions_example/dbService/db_service.dart';

class DBServiceSingleton {
  static DBService? _dbService;

  DBServiceSingleton._();

  static DBService getDBInstance() {
    if (_dbService == null) {
      return DBService(AppState.supabaseUrl!, AppState.serviceRole!);
    }
    return _dbService!;
  }
}
