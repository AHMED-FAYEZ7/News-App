abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavState extends AppStates {}

class AppLoadingGetBusinessState extends AppStates {}

class AppGetBusinessSuccessState extends AppStates {}
class AppGetBusinessErrorState extends AppStates {
  final String error;

  AppGetBusinessErrorState(this.error);
}

class AppLoadingGetSportsState extends AppStates {}

class AppGetSportsSuccessState extends AppStates {}
class AppGetSportsErrorState extends AppStates {
  final String error;

  AppGetSportsErrorState(this.error);
}

class AppLoadingGetScienceState extends AppStates {}

class AppGetScienceSuccessState extends AppStates {}
class AppGetScienceErrorState extends AppStates {
  final String error;

  AppGetScienceErrorState(this.error);
}

