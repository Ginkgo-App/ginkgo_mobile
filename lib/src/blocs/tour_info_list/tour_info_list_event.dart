part of 'tour_info_list_bloc.dart';

@immutable
abstract class TourInfoListEvent {
  @override
  String toString() => runtimeType.toString();
}

///
/// `userId` == 0 => Get me's tour infos
///
class TourInfoListEventFetch extends TourInfoListEvent {
  final String keyword;

  TourInfoListEventFetch({this.keyword});

  @override
  String toString() => '$runtimeType Keyword: $keyword';
}
