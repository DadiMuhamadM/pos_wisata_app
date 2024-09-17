import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos_wisata_app/data/datasources/product_remote_datasource.dart';
import 'package:pos_wisata_app/data/models/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  //add
  final ProductRemoteDatasource productRemoteDatasource;
  ProductBloc(
    this.productRemoteDatasource,
  ) : super(_Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(_Loading());
      final response = await productRemoteDatasource.getProduct();

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data.data ?? [])),
      );
    });
  }
}
