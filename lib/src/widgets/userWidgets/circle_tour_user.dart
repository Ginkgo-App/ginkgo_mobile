part of user_widgets;

class CircleTourUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              boxShadow: DesignColor.backgroundColorShadow,
              borderRadius: BorderRadius.circular(90)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset(
              Assets.images.defaultAvatar,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Doraemono',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Tourist guide',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 5,
        ),
        Stack(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                Assets.icons.ribbon,
                width: 80,
                height: 15,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '11 chuyến đi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
