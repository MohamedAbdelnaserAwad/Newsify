import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsify/layout/cubit/cubit.dart';
import 'package:newsify/layout/cubit/states.dart';
import 'package:newsify/layout/news_layout.dart';
import 'package:newsify/shared/bloc_observer.dart';
import 'package:newsify/shared/network/local/cache_helper.dart';
import 'package:newsify/shared/styles/themes.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;


  MyApp(this.isDark); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

