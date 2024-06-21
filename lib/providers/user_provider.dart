

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/user.dart';
import 'package:insa_report/services/securestore.dart';

final userProvider = FutureProvider<User?>((ref) async {
  // await Future.delayed(const Duration(seconds: 19));
  return SecureStore.getUser();
},);