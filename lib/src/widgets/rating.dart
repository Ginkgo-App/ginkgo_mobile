part of 'widgets.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({Key key, @required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        ...List.generate(
          5,
          (i) => Container(
            width: 25,
            height: 3,
            color: rating >= i + 1
                ? DesignColor.lightRed
                : DesignColor.lighterPink,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${rating.round()}/5 điểm',
          style: context.textTheme.overline.copyWith(
            color: DesignColor.darkRed,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
