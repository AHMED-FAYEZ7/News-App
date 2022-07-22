import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports,
        ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science,
        ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNav(int index)
  {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(AppLoadingGetBusinessState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'60e6fb3ed24f4b0ca2ae8935acacf006',
      },
    ).then((value)
    {
      // print(value.data["articles"][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(AppGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(AppLoadingGetSportsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'60e6fb3ed24f4b0ca2ae8935acacf006',
      },
    ).then((value)
    {
      // print(value.data["articles"][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(AppGetSportsSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(AppLoadingGetScienceState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'60e6fb3ed24f4b0ca2ae8935acacf006',
      },
    ).then((value)
    {
      // print(value.data["articles"][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);
      emit(AppGetScienceSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetScienceErrorState(error.toString()));
    });
  }
  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(AppLoadingGetSearchState());
    // search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'60e6fb3ed24f4b0ca2ae8935acacf006',
      },
    ).then((value)
    {
      // print(value.data["articles"][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(AppGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeStates());
      });
    }
  }





}