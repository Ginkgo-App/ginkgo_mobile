part of create_tour_info_widgets;

class SuccessCreateTourInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: <Widget>[
          SvgPicture.asset(
            Assets.icons.smile,
            width: 50,
            height: 50,
          ),
          Text(
            'Thành công rồi !!!',
          )
          // style: TextStyle(decorationColor: GradientColor.of(context).primaryGradient,),)
        ],
      ),
      content: Column(
        children: <Widget>[
          Text(
            'Bạn đã tạo thành công cho các chuyến đi của bạn với những thông tin sau:',
            style: TextStyle(fontSize: 12),
            maxLines: 2,
          ),
          RichText(
            text: TextSpan(
              text: '  Tên:',
              style: TextStyle(fontStyle: FontStyle.italic),
              children: <TextSpan>[
                TextSpan(
                    text: 'Tour Tây Nguyên',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '  Địa điểm đầu:',
              style: TextStyle(fontStyle: FontStyle.italic),
              children: <TextSpan>[
                TextSpan(
                    text: 'Buôn Mê Thuột',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '  Địa điểm cuối:',
              style: TextStyle(fontStyle: FontStyle.italic),
              children: <TextSpan>[
                TextSpan(
                    text: 'Tokyo',
                    
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
