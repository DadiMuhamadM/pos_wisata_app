import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_wisata_app/data/datasources/auth_remote_datasource.dart';
import 'package:pos_wisata_app/data/models/request/login_request_model.dart';
import 'package:pos_wisata_app/data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(this.authRemoteDatasource) : super(_Initial()) {
    on<_Login>(
      (event, emit) async {
        // Request dulu data email dan pass yang dari event
        emit(const _Loading());
        final dataRequest = LoginRequestModel(
          email: event.email,
          password: event.password,
        );

        final response = await authRemoteDatasource.login(dataRequest);
        // Jika respon kiri error, kanan success
        response.fold(
          (error) => emit(
            (_Error(error)),
          ),
          (data) => emit(
            (_Success(data)),
          ),
        );
      },
    );
  }
}
