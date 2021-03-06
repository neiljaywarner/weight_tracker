import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/model/weight_entry.dart';

@immutable
class ReduxState {
  final List<WeightEntry> entries;
  final String unit;
  final RemovedEntryState removedEntryState;
  final WeightEntryDialogReduxState weightEntryDialogState;
  final FirebaseState firebaseState;
  final MainPageReduxState mainPageState;
  final ProgressChartState progressChartState;
  final double weightFromNotes;

  const ReduxState({
    this.firebaseState = const FirebaseState(),
    this.entries = const [],
    this.mainPageState = const MainPageReduxState(),
    this.unit = 'kg',
    this.removedEntryState = const RemovedEntryState(),
    this.weightEntryDialogState = const WeightEntryDialogReduxState(),
    this.progressChartState = const ProgressChartState(),
    this.weightFromNotes,
  });

  ReduxState copyWith({
    FirebaseState firebaseState,
    List<WeightEntry> entries,
    bool hasEntryBeenAdded,
    String unit,
    RemovedEntryState removedEntryState,
    WeightEntryDialogReduxState weightEntryDialogState,
    ProgressChartState progressChartState,
  }) {
    return new ReduxState(
        firebaseState: firebaseState ?? this.firebaseState,
        entries: entries ?? this.entries,
        mainPageState: mainPageState ?? this.mainPageState,
        unit: unit ?? this.unit,
        weightEntryDialogState:
        weightEntryDialogState ?? this.weightEntryDialogState,
        removedEntryState: removedEntryState ?? this.removedEntryState,
        progressChartState: progressChartState ?? this.progressChartState);
  }
}

@immutable
class ProgressChartState {
  final int daysToShow;
  final int previousDaysToShow;
  final DateTime lastFinishedDateTime;

  const ProgressChartState(
      {this.daysToShow = 31, this.previousDaysToShow = 31, this.lastFinishedDateTime});

  ProgressChartState copyWith(
      {int daysToShow, int previousDaysToShow, DateTime lastFinishedDateTime}) {
    return new ProgressChartState(
      daysToShow: daysToShow ?? this.daysToShow,
      previousDaysToShow: previousDaysToShow ?? this.previousDaysToShow,
      lastFinishedDateTime: lastFinishedDateTime ?? this.lastFinishedDateTime,
    );
  }
}

@immutable
class RemovedEntryState {
  final WeightEntry lastRemovedEntry;
  final bool hasEntryBeenRemoved; //in other words: should show snackbar?

  const RemovedEntryState(
      {this.lastRemovedEntry, this.hasEntryBeenRemoved = false});

  RemovedEntryState copyWith({
    WeightEntry lastRemovedEntry,
    bool hasEntryBeenRemoved,
  }) {
    return new RemovedEntryState(
        lastRemovedEntry: lastRemovedEntry ?? this.lastRemovedEntry,
        hasEntryBeenRemoved: hasEntryBeenRemoved ?? this.hasEntryBeenRemoved);
  }
}

@immutable
class WeightEntryDialogReduxState {
  final bool isEditMode;
  final WeightEntry activeEntry; //entry to show in detail dialog

  const WeightEntryDialogReduxState({this.isEditMode, this.activeEntry});

  WeightEntryDialogReduxState copyWith({
    bool isEditMode,
    WeightEntry activeEntry,
  }) {
    return new WeightEntryDialogReduxState(
        isEditMode: isEditMode ?? this.isEditMode,
        activeEntry: activeEntry ?? this.activeEntry);
  }
}

@immutable
class FirebaseState {
  final FirebaseUser firebaseUser;
  final DatabaseReference mainReference;

  const FirebaseState({this.firebaseUser, this.mainReference});

  FirebaseState copyWith({
    FirebaseUser firebaseUser,
    DatabaseReference mainReference,
  }) {
    return new FirebaseState(
        firebaseUser: firebaseUser ?? this.firebaseUser,
        mainReference: mainReference ?? this.mainReference);
  }
}

@immutable
class MainPageReduxState {
  final bool hasEntryBeenAdded; //in other words: should scroll to top?

  const MainPageReduxState({this.hasEntryBeenAdded = false});

  MainPageReduxState copyWith({bool hasEntryBeenAdded}) {
    return new MainPageReduxState(
        hasEntryBeenAdded: hasEntryBeenAdded ?? this.hasEntryBeenAdded);
  }
}
