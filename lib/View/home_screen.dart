// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_app/App_Const/config.dart';
import 'package:cat_app/Controller/cats_provider.dart';
import 'package:cat_app/Model/server_exception.dart';
import 'package:cat_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async{
      try {
        await Provider.of<CatsProvider>(context, listen: false).loadCats();
      } on ServerException catch (e) {
        openToast(context, e.cause);
        log(e.additonalLogInfo.toString());
      } catch (e) {
        openToast(context, "unexpected error");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CatsProvider catsProvider = Provider.of<CatsProvider>(context);
    return Scaffold(
        body: Center(
            child: catsProvider.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Expanded(
                            child:  MasonryGridView.count(
                                itemCount: catsProvider.cats.length,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2,

                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: (){
                                      openToast(context, catsProvider.cats[i].id ??"id isn't available");
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: CachedNetworkImage(
                                                  imageUrl: catsProvider.cats[i].url??"",
                                                  fit: BoxFit.contain,
                                                  errorWidget: (context, url, error) => Image.asset(AppConfig.noImgPath),
                                        ),
                                      ),
                                  );
                                }))
                      ])));
  }
}

