import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedUser = StateProvider((ref) => UserData(
      firstname: '',
      lastname: '',
      age: 0,
      email: '',
      isFramer: false,
      photourl: ''
    ));
