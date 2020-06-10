part of '../screens.dart';

class CreateTourInfo extends StatefulWidget {
  @override
  _CreateTourInfoState createState() => _CreateTourInfoState();
}

class _CreateTourInfoState extends State<CreateTourInfo> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Tạo khuôn mẫu chuyến đi',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Text(
                'Tạo nên khung xương cho những chuyến đi của bạn',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: DesignColor.darkRed),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(
                text: '*',
                style: TextStyle(color: DesignColor.darkRed),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Tên Khuôn mẫu:',
                      style: TextStyle(
                          color: context.colorScheme.onBackground,
                          fontSize: 12,
                          fontStyle: FontStyle.italic)),
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: context.colorScheme.onPrimary,
                  hoverColor: context.colorScheme.onPrimary,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide: new BorderSide(color: DesignColor.lightRed),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide:
                        new BorderSide(color: context.colorScheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                text: '*',
                style: TextStyle(color: DesignColor.darkRed),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Địa điểm đầu:',
                      style: TextStyle(
                          color: context.colorScheme.onBackground,
                          fontSize: 12,
                          fontStyle: FontStyle.italic)),
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: context.colorScheme.onPrimary,
                  hoverColor: context.colorScheme.onPrimary,
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.expand_more),
                    onTap: () {
                      PlaceBottomSheet.of(context).show();
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide: new BorderSide(color: DesignColor.lightRed),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide:
                        new BorderSide(color: context.colorScheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Địa điểm chính xác (không bắt buộc):',
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: context.colorScheme.onPrimary,
                  hoverColor: context.colorScheme.onPrimary,
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.expand_more),
                    onTap: () {},
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide: new BorderSide(color: DesignColor.lightRed),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide:
                        new BorderSide(color: context.colorScheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                text: '*',
                style: TextStyle(color: DesignColor.darkRed),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Địa điểm Cuối:',
                      style: TextStyle(
                          color: context.colorScheme.onBackground,
                          fontSize: 12,
                          fontStyle: FontStyle.italic)),
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: context.colorScheme.onPrimary,
                  hoverColor: context.colorScheme.onPrimary,
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.expand_more),
                    onTap: () {},
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide: new BorderSide(color: DesignColor.lightRed),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide:
                        new BorderSide(color: context.colorScheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Địa điểm chính xác (không bắt buộc):',
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: context.colorScheme.onPrimary,
                  hoverColor: context.colorScheme.onPrimary,
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.expand_more),
                    onTap: () {},
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide: new BorderSide(color: DesignColor.lightRed),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                    borderSide:
                        new BorderSide(color: context.colorScheme.onSurface),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '*',
                  style: TextStyle(color: DesignColor.darkRed),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Hình ảnh:',
                        style: TextStyle(
                            color: context.colorScheme.onBackground,
                            fontSize: 12,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SpacingRow(
                spacing: 10,
                children: <Widget>[
                  _buildImageItem(),
                  _buildImageItem(),
                  Container(
                    width: 65,
                    height: 45,
                    child: Image.asset(
                      Assets.images.addImage,
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  _buildImageItem(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                title: 'Hoàn tất',
                width: 350,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessCreateTourInfoDialog()),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageItem() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.onSurface,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      width: 65,
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/83127578_781402629026013_5572345287713751040_n.jpg?_nc_cat=111&_nc_sid=85a577&_nc_ohc=9e9cgfu5lukAX8EuVG8&_nc_ht=scontent.fsgn2-1.fna&oh=51c5512f6858683b2099ee403bdd5feb&oe=5EFB3E22',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                bottom: 29,
                left: 49,
                right: 1,
                top: 1,
                child: GestureDetector(
                  child: Icon(
                    Icons.clear,
                    size: 15,
                    color: context.colorScheme.onBackground,
                  ),
                  onTap: () {},
                )),
          ],
        ),
      ),
    );
  }
}
