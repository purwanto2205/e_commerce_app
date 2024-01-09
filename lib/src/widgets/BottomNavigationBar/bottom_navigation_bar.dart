import 'package:e_commerce_app/src/themes/light_color.dart';
import 'package:e_commerce_app/src/widgets/BottomNavigationBar/bottom_curve_painter.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  Function(int) onIconPressedCallback;

  CustomBottomNavigationBar({ Key? key, required this.onIconPressedCallback })
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );
    _yController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() { });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value = _indexPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();

    super.dispose();
  }

  double _indexPosition(int index) {
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonWidth) / 2;

    return startX + index.toDouble() * buttonWidth / buttonCount +
    buttonWidth / (buttonCount * 2.0);
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400) {
      return 400;
    }

    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating ) return;
    widget.onIconPressedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
    _yController.value = 1.0;
    _xController.animateTo(
      _indexPosition(index) / MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 620)
    );
    Future.delayed(
        const Duration(milliseconds: 500),
        () {
          _yController.animateTo(
            1.0,
            duration: const Duration(milliseconds: 1200)
          );
        }
    );
    _yController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);

    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(
            _yController.velocity.sign * 0.5 + 0.5
          ),
          Theme.of(context).primaryColor
      ),
    );
  }

  Widget _icon(IconData icon, bool isEnable, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _handlePressed(index);
        },
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isEnable ? 40 : 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isEnable ? LightColor.orange : Colors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: isEnable ? const Color(0xfffeece2) : Colors.white,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(5, 5)
                )
              ]
            ),
            child: Opacity(
              opacity: isEnable ? _yController.value : 1,
              child: Icon(
                  icon,
                  color: isEnable ? LightColor.background : Theme.of(context).iconTheme.color
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    const height = 60.0;
    return SizedBox(
      width: appSize.width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              bottom: 0,
              width: appSize.width,
              height: height - 10,
              child: _buildBackground()
          ),
          Positioned(
            top: 0,
            height: height,
            width: _getButtonContainerWidth(),
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               _icon(Icons.home, _selectedIndex == 0, 0),
               _icon(Icons.search, _selectedIndex == 1, 1),
               _icon(Icons.card_travel, _selectedIndex == 2, 2),
               _icon(Icons.favorite_border, _selectedIndex == 3, 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
