import 'package:chocolate_store/screen/all_product_screen/all_product_widget/custom_text_field/cubit/text_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home_page_screen/home_page_model/prod_class.dart';

class GetSearchProdCubit extends Cubit<GetSearchProdState> {
  GetSearchProdCubit() : super(InitialState());

//Api
  GetProduct({required String prodName}) {

      //try_catch
      //Api service
       late ProdInfo prodInfo;
      getProdInfo({required NameProd})async{
        try{  prodInfo = ProdInfo( nameProd: prodInfo.nameProd, prodId: 123, description: '', price: '',);
          emit(LoadedProd());
    } on Exception catch (e) {
      emit(FailureProd());
    }

  }

}}
