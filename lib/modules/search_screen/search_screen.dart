import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/favourites_screen/favorites_screen.dart';
import 'package:shop_app/modules/search_screen/search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shop_cubit/shop_cubit.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ( BuildContext context)=> SearchCubit(),
    child: BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  customFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (s){
                    if(s.isEmpty){
                      return 'Search must not be empty';
                    }
                  }, label: 'Search',
                  prefix: Icons.search,
                  onSubmit: (text){
                        cubit.search(text);
                  }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            searchItem(cubit.model!.data!.data![index], context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.model!.data!.data!.length),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
Widget searchItem(SearchDataModel model, context) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image.toString()),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3, fontSize: 14),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          Text(
                            model.price!.round().toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),

                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.id!.toInt());

                              print(model.id);
                            },
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: ShopCubit.get(context)
                                    .favorites![model.id]!
                                    ? defaultColor
                                    : Colors.grey,
                                child: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                )),
                            iconSize: 26,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ],
    ),
  ),
);