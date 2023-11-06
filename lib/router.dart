// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

//Auth
import './features/auth/view/signup_page.dart';
import './features/auth/view/login_page.dart';
import './features/auth/view/complete_profile_page.dart';
import './features/auth/view/set_goal_page.dart';
import './features/auth/view/welcome_page.dart';

//Community
import './features/community/views/community_page.dart';
import './features/community/views/search_community_page.dart';
import './features/community/views/view_community_page.dart';
import './features/community/views/create_community_page.dart';
import './features/community/views/view_members_page.dart';
import './features/community/views/community_chat_page.dart';

//Home
import './features/home/home_view.dart';
import './features/home/activity_tracker_view.dart';
import './features/home/notification_view.dart';
import './features/home/finished_workout_view.dart';
import './features/home/blank_view.dart';

//Main Tab
import './features/main_tab/main_tab_view.dart';
import './features/main_tab/select_view.dart';

//Meal Planner
import './features/meal_planner/meal_planner_view.dart';
import './features/meal_planner/food_info_details_view.dart';
import './features/meal_planner/meal_food_details_view.dart';
import './features/meal_planner/meal_schedule_view.dart';

//On Boarding
import './features/on_boarding/on_boarding_view.dart';
import './features/on_boarding/started_view.dart';

//Photo Progress
import './features/photo_progress/comparison_view.dart';
import './features/photo_progress/photo_progress_view.dart';
import './features/photo_progress/result_view.dart';

//Profile
import './features/profile/profile_view.dart';

//Sleep Tracker
import './features/sleep_tracker/sleep_tracker_view.dart';
import './features/sleep_tracker/sleep_schedule_view.dart';
import './features/sleep_tracker/sleep_add_alarm_view.dart';

//Workout Tracker
import './features/workout_tracker/views/workout_tracker_view.dart';
import './features/workout_tracker/views/workout_schedule_view.dart';
import './features/workout_tracker/views/workour_detail_view.dart';
import './features/workout_tracker/views/add_schedule_view.dart';
import './features/workout_tracker/views/exercises_step_details.dart';

//Logged In Routes
final loggedInRoutes = RouteMap(
  routes: {
    //Home Routes
    '/': (route) => const MaterialPage(child: WelcomePage()),
    '/main-tab': (route) => const MaterialPage(child: MainTabView()),
    '/complete-profile': (route) =>
        const MaterialPage(child: CompleteProfilePage()),
    '/set-goal': (route) => const MaterialPage(child: SetGoalPage()),

    //Community Routes
    '/community': (route) => const MaterialPage(child: CommunityPage()),
    '/create-community': (route) =>
        const MaterialPage(child: CreateCommunityPage()),
    '/search-community': (route) =>
        const MaterialPage(child: SearchCommunityPage()),
    '/view-community/:id': (route) => MaterialPage(
          child: ViewCommunityPage(
            communityId: route.pathParameters['id']!,
          ),
        ),
    '/:id/members': (route) => MaterialPage(
          child: ViewMembersPage(
            communityId: route.pathParameters['id']!,
          ),
        ),
        '/:id/chat': (route) => MaterialPage(
          child: CommunityChatPage(
            communityId: route.pathParameters['id']!,
          ),
        ),

    //Workout Tracker Routes
    '/workout-schedule': (route) =>
        const MaterialPage(child: WorkoutScheduleView()),

    //Meal Planner Routes

    //Sleep Tracker Routes

    //Photo Progress Routes
  },
);

//Logged Out Routes
final loggedOutRoutes = RouteMap(
  routes: {
    // Authentication Route
    '/': (route) => const MaterialPage(child: SignUpPage()),
    '/login': (route) => const MaterialPage(child: LoginPage()),
  },
);
