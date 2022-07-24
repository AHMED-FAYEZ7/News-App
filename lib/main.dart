import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

void main()
{
  BlocOverrides.runZoned(() async
    {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getBoolean(key: 'isDark');
      runApp(MyApp(isDark));

    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
      ..getBusiness()
      ..getSports()
      ..getScience()
      ..changeAppMode(
        fromShared: isDark,
      ),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context , state) {},
        builder: (context , state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }

}