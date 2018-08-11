import 'dart:collection';

import 'package:flutter/material.dart';
import 'item_reviews_page.dart';
import 'dart:math' as math;

//enums
enum BetLevel { PlayType, PlayResult, PlayResultDetails, PlayCost }

//main page
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
  static const String routeName = '/Landing';
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: themeData.disabledColor))),
              child: new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: <Widget>[],
                ),
              ));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Image
                .asset('res/nfl.png'), // Icon(Icons.nfl, color: Colors.black),
          ),
          title: Text('Patriots vs Eagles',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('beclothed.com',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showBottomSheet,
                  color: Colors.black38),
              Padding(
                padding: EdgeInsets.only(left: 64.0),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.grey[400],
                    size: 16.0,
                  ),
                  Text('\$ 25', style: TextStyle(color: Colors.green)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child:
                        Text('\$ 200', style: TextStyle(color: Colors.green)),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: _showBottomSheet,
                color: Colors.black38,
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            SinglePlay(),
            Spacer(),
            BetPocket(onBetChanged: (bool value) {},),
            Spacer(),
          ],
        ));
  }


}

//each play's data leads to animated result of said play
class SinglePlay extends StatefulWidget {
  @override
  _SinglePayState createState() => _SinglePayState();
  static const String routeName = '/Bet';
}

class _SinglePayState extends State<SinglePlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize(
            size: Size.fromHeight(270.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 0.0),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(0.0),
                    shadowColor: Color(0x808080ff),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// Title and rating
                          ///
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 25.0),
                                      child: Text(_getQuarter(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 20.0),
                                      child: Icon(Icons.access_time)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 5.0),
                                      child: Text(_getClockTime(),
                                          style: TextStyle())),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 45.0),
                                      child: Text(_getAwayTeam(),
                                          style:
                                              TextStyle(color: Colors.blue))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 20.0, left: 0.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(20.0),
                                        child: Material(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0, left: 0.0),
                                      child: Text(_getHomeTeam(),
                                          style:
                                              TextStyle(color: Colors.green))),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 60.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Material(
                                          elevation: 8.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Image.asset('res/tb.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Icon(Icons.arrow_right,
                                            color: Colors.grey, size: 28.0),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(15.0),
                                        child: Material(
                                          elevation: 8.0,
                                          color: Colors.white,
                                          shadowColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          child: Image.asset('res/bg.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0)),
                              Text(_getPlayDescription(),
                                  style: TextStyle(
                                      fontFamily: 'Monsterrat-Thin',
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Item image
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(35.0),
                      child: Material(
                        elevation: 0.0,
                        color: Colors.indigo,
                        shadowColor: Colors.grey[300],
                        shape: CircleBorder(),
                        child: Center(
                            child: Icon(
                          Icons.blur_off,
                          color: Colors.black,
                          size: 45.0,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String _getQuarter() {
    return 'Q2';
  }

  String _getClockTime() {
    return '10:30';
  }

  String _getAwayTeam() {
    return 'PH';
  }

  String _getHomeTeam() {
    return 'NE';
  }

  String _getPlayDescription() {
    return 'T.Brady sacked at NE 26 for -4 yards (B.Graham) T.Brady FUMBLES, forced by B.Graham. Fumble RECOVERED by PHI-D.Barnett at NE 29.                                         Tackled by D.Andrews at NE 31.';
  }

  String _getPlayTypeLetter() {
    return 'F';
  }
}

//Betting section for next play, quarter, half
class BetPocket extends StatefulWidget {
  var betChanged = false;
  final ValueChanged<bool> onBetChanged;

  BetPocket({Key key, this.betChanged: false, @required this.onBetChanged})
      : super(key: key);

  @override
  _BetPocketState createState() => _BetPocketState();
  static const String routeName = '/Bet';
}

class _BetPocketState extends State<BetPocket> {
  bool FortyYdsSelected = false;
  bool PassTouchdownSelected = false;
  bool FirstDownSelected = false;
  bool FumbleSelected = false;
  bool PersonalFoulSelected = false;
  bool SafetySelected = false;
  bool SackSelected = false;
  bool PuntSelected = false;
  bool KickSelected = false;
  bool KickPuntSelected = false;
  bool FieldGoalSelected = false;
  bool InterceptionSelected = false;
  bool RushTouchdownSelected = false;
  bool FifteenSelected = false;
  bool TwentyYdsSelected = false;
  bool FumbleRecovered = false;
  bool FumbleLossed = false;
  bool TwentyFiveYdsSelected = false;
  bool ThirtyYdsSelected = false;
  bool FiftyYdsSelected = false;
  bool CompletionSelected = false;
  bool LossSelected = false;
  bool RunSelected = false;
  bool PassSelected = false;
  bool PlayactionSelected = false;
  bool TurnoverSelected = false;
  bool TouchdownSelected = false;
  bool PlayTypeSelected = false;
  bool IncompletionSelected = false;
  bool ScoreSelected = false;
  bool BlockSelected = false;

  List<Widget> defList;
  List<Widget> runList;
  List<Widget> passList;
  List<Widget> playActionList;
  List<Widget> puntList;
  List<Widget> fieldGoalList;
  List<Widget> kickList;
  List<Widget> ydsList;
  List<Widget> retList;
  List<Widget> sackList;
  List<Widget> fumbleList;
  BetLevel _betLevel = BetLevel.PlayType;

  List<bool> selections = new List<bool>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox.fromSize(
            size: Size.fromHeight(270.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                /// Item description inside a material
                Container(
                  height: 50.0,
                  margin: EdgeInsets.all(0.0),
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(0.0),
                    color: Colors.grey[100],
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 3.0),
                      child: Column(
                        children: <Widget>[
                      SizedBox.fromSize(
                      size: Size.fromHeight(50.0),
                      child: _getBetPocketList()
                      ),
                      Spacer(),
                    SizedBox.fromSize(
                      size: Size.fromHeight(200.0),
                      child: _getBetOptions(),
                    ),
                      Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _getBetPocketList() {
    LinkedHashMap betPocketList = new LinkedHashMap<String, Widget>();
    //possible play scenarios
    if(PassSelected)
        betPocketList['play_type']= new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( Icons.directions_walk,
            color: Colors.black), // new Text('2'),
        );

    if(RunSelected)
        betPocketList['play_type']= new CircleAvatar(
        key: Key('run'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(Icons.directions_run,
            color: Colors.black), // new Text('2'),
      );

    if(PlayactionSelected)
      betPocketList['play_type']=new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon(Icons.device_hub,
            color: Colors.black), // new Text('2'),
      );

    if(FifteenSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_drop_up,
            color: Colors.white), // new Text('2'),
      );


    if(TwentyYdsSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_drop_up,
            color: Colors.white), // new Text('2'),
      );

    if(TwentyFiveYdsSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_drop_up,
            color: Colors.white), // new Text('2'),
      );

    if(ThirtyYdsSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_drop_up,
            color: Colors.white), // new Text('2'),
      );


    if(FortyYdsSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        child:Icon(Icons.arrow_drop_down,
            color: Colors.white),
      );

    if(FiftyYdsSelected)
      betPocketList['play_yds'] = new CircleAvatar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        child:Icon(Icons.arrow_drop_down,
            color: Colors.white),
      );

    //possibly results
    if(RushTouchdownSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.airline_seat_flat_angled,
            color: Colors.black), // new Text('2'),
      );

    if(PassTouchdownSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.accessibility,
            color: Colors.black), // new Text('2'),
      );

    if(FirstDownSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.blueGrey[400],
        foregroundColor: Colors.white,
        child: Icon(Icons.all_out,
            color: Colors.black), // new Text('2'),
      );

    if(PersonalFoulSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        child: Icon(Icons.border_clear, color: Colors.black),

        /// new Text('2'),
      );

    if(FumbleSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: Icon(Icons.blur_off,
            color: Colors.black), // new Text('2'),
      );

    if(SackSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_downward,
            color: Colors.black), // new Text('2'),
      );

    if(PuntSelected)
      betPocketList['play_type']= new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.border_style,
            color: Colors.black), // new Text('2'),
      );

    if(SafetySelected)
      betPocketList['safe']= new CircleAvatar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: Icon(Icons.ac_unit,
            color: Colors.white),
      );

    if(InterceptionSelected)
      betPocketList['play_result']= new CircleAvatar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.brightness_low,
            color: Colors.black), // new Text('2'),
      );

    if(KickPuntSelected)
      betPocketList['play_type']= new CircleAvatar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.brightness_low,
            color: Colors.black), // new Text('2'),
      );

    if(FieldGoalSelected)
      betPocketList['play_type']= new CircleAvatar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.brightness_low,
            color: Colors.black), // new Text('2'),
      );
    //add the default widgets
    betPocketList['spacer']= new Spacer();

    betPocketList['padding']=  new AnimatedOpacity(
        opacity: PlayTypeSelected ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: new RaisedButton(
          splashColor: Colors.white,
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
          onPressed: ()=>  setState(() => (
                _resetBetLevel()),
            ),
          ),// n),ew Text('2'),
        ),
    );

    List<Widget> wids = new List<Widget>();
    betPocketList.values.forEach((item) => wids.add(item));

    return new Row(
      children: wids
    );
  }

  _getBetOptions() {
    List betOptionsList = new List<Widget>();

    if (_betLevel == BetLevel.PlayType) {


      if (PassSelected) {
        betOptionsList = passList == null ? _getPassList() : passList;
        RunSelected = false;
        PlayactionSelected = false;
        KickSelected = false;
        PuntSelected = false;
        FieldGoalSelected = false;
      }
      else if (RunSelected) {
        betOptionsList = runList == null ? _getRunList() : runList;
        PassSelected = false;
        PlayactionSelected = false;
        KickSelected = false;
        PuntSelected = false;
        FieldGoalSelected = false;

      }
      else if (PlayactionSelected) {
        betOptionsList = passList == null ? _getPassList() : passList;
        PassSelected = false;
        RunSelected = false;
        KickSelected = false;
        PuntSelected = false;
        FieldGoalSelected = false;
      }
      else if (PuntSelected) {
        betOptionsList = puntList == null ? _getPuntList() : puntList;
        PassSelected = false;
        RunSelected = false;
        KickSelected = false;
        FieldGoalSelected = false;
      }
      else if (KickSelected) {
        betOptionsList = kickList == null ? _getKickList() : kickList;
        PassSelected = false;
        RunSelected = false;
        PuntSelected = false;
        FieldGoalSelected = false;
      }
      else if (PuntSelected) {
        betOptionsList = puntList == null ? _getPuntList() : puntList;
        PassSelected = false;
        RunSelected = false;
        KickSelected = false;
        FieldGoalSelected = false;
      }
      else if (FieldGoalSelected) {
        betOptionsList =
        fieldGoalList == null ? _getFieldgoalList() : fieldGoalList;
        PassSelected = false;
        RunSelected = false;
        PuntSelected = false;
        KickSelected = false;
      }
      _betLevel = BetLevel.PlayResult;
    }
    else if (_betLevel == BetLevel.PlayResult) {

      if (CompletionSelected) {
        betOptionsList = ydsList == null ? _getyardsList() : ydsList;
        IncompletionSelected = false;
        TurnoverSelected = false;
        SackSelected = false;
        FumbleSelected = false;
        PersonalFoulSelected = false;
        ScoreSelected = false;
      }
      else if (IncompletionSelected) {
        betOptionsList = new List<Widget>();
        CompletionSelected = false;
        TurnoverSelected = false;
        SackSelected = false;
        FumbleSelected = false;
        PersonalFoulSelected = false;
         ScoreSelected = false;
      }
       else if (ScoreSelected) {
        betOptionsList = new List<Widget>();
        CompletionSelected = false;
        IncompletionSelected = false;
        TurnoverSelected = false;
        SackSelected = false;
        FumbleSelected = false;
        PersonalFoulSelected = false;
      }

      else if (TurnoverSelected) {
        betOptionsList = new List<Widget>();
        CompletionSelected = false;
        IncompletionSelected = false;
        SackSelected = false;
        FumbleSelected = false;
        PersonalFoulSelected = false;
        ScoreSelected = false;
      }
      else if (SackSelected) {
        betOptionsList = sackList == null ? _getSackList : sackList;
         CompletionSelected = false;
        TurnoverSelected = false;
        IncompletionSelected = false;
        FumbleSelected = false;
        PersonalFoulSelected = false;
        ScoreSelected = false;
      }
      else if (FumbleSelected) {
        betOptionsList = fumbleList == null ? _getFumbleList : fumbleList;
         CompletionSelected = false;
        TurnoverSelected = false;
        SackSelected = false;
        IncompletionSelected = false;
        PersonalFoulSelected = false;
        ScoreSelected = false;
      }
      _betLevel = BetLevel.PlayResultDetails;
    }
    else if (_betLevel == BetLevel.PlayResultDetails) {
      if (FirstDownSelected) {
        betOptionsList = ydsList == null ? _getyardsList() : ydsList;
        InterceptionSelected = false;
        FumbleSelected = false;
        TouchdownSelected = false;
        BlockSelected = false;
      }
      else if (InterceptionSelected) {
        betOptionsList = new List<Widget>();
        FirstDownSelected = false;
        FumbleSelected = false;
        TouchdownSelected = false;
        BlockSelected = false;
      }
      else if (FumbleSelected) {
        betOptionsList = retList == null ? _getFumbleList() : retList;
        InterceptionSelected = false;
        FirstDownSelected = false;
        TouchdownSelected = false;
        BlockSelected = false;
      }
       else if (TouchdownSelected) {
        betOptionsList = new List<Widget>();
        InterceptionSelected = false;
        FumbleSelected = false;
        FirstDownSelected = false;
        BlockSelected = false;
      }
      else if (BlockSelected) {
        betOptionsList = retList == null ? _getBlockList() : retList;
        InterceptionSelected = false;
        FumbleSelected = false;
        TouchdownSelected = false;
        FirstDownSelected = false;
      }

      _betLevel = BetLevel.PlayCost;
    }
    else if(_betLevel == BetLevel.PlayCost){
       betOptionsList.addAll(ydsList == null ? _getyardsList() : ydsList);
    }

    if (!PlayTypeSelected) {
      betOptionsList = defList == null ? _getDefaultList() : defList;
    }

    return Wrap(
        spacing: 3.0, // gap between adjacent chips
        runSpacing: 3.0, // g
        children: betOptionsList
    );
  }

  _resetBetLevel(){
    _betLevel = BetLevel.PlayType;
    PlayTypeSelected = false;
  }

  List<Widget> _getFumbleList() {
    var fumbleList = new List<Widget>();

    fumbleList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(FumbleRecovered ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Recovered',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FumbleRecovered,
      onSelected: (selected) => setState(
              () => FumbleRecovered = selected),
    ));
    fumbleList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(FumbleLossed ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'lossed',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FumbleLossed,
      onSelected: (selected) => setState(
              () => FumbleLossed = selected),
    ));
    return fumbleList;
  }

  List<Widget> _getSackList() {
     var sackList = new List<Widget>();
     sackList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fumble',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
     sackList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Yds loss',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    return sackList;
  }

  List<Widget> _getReturnList() {
    var retList = new List<Widget>();
    retList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret 20 yds +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    retList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret 40 yds +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    retList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Ret TD',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    return retList;
  }

  List<Widget> _getyardsList() {
    var ydsList = new List<Widget>();
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(FifteenSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '15 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FifteenSelected,
      onSelected: (selected) => setState(
              () => FifteenSelected = selected),
    ));
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '20 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(TwentyFiveYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '25 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyFiveYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyFiveYdsSelected = selected),
    ));
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(ThirtyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '30 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: ThirtyYdsSelected,
      onSelected: (selected) => setState(
              () => ThirtyYdsSelected = selected),
    ));
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(FiftyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        '50 +',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: FiftyYdsSelected,
      onSelected: (selected) => setState(
              () => FiftyYdsSelected = selected),
    ));
    ydsList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(LossSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Loss',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: LossSelected,
      onSelected: (selected) => setState(
              () => LossSelected = selected),
    ));
    return ydsList;
  }

  List<Widget> _getKickList() {
     var kickList = new List<Widget>();
    kickList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Kick off',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    kickList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Onside kick',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    return kickList;
  }

  List<Widget> _getPuntList() {
    var puntList = new List<Widget>();
    puntList = _getReturnList();
    puntList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Punt block',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    return puntList;
  }

  List<Widget> _getFieldgoalList() {
    var fieldGoalList = new List<Widget>();
    fieldGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(TwentyYdsSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fg good',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: TwentyYdsSelected,
      onSelected: (selected) => setState(
              () => TwentyYdsSelected = selected),
    ));
    fieldGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fg no good',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    fieldGoalList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'ret TD',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    return fieldGoalList;
  }

  List<Widget> _getPassList() {
     var passList = new List<Widget>();
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(CompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Completion',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: CompletionSelected,
      onSelected: (selected) => setState(
              () => CompletionSelected = selected),
    ));
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(IncompletionSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Incompletion',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: IncompletionSelected,
      onSelected: (selected) => setState(
              () => IncompletionSelected = selected),
    ));
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Sack',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fumble',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Interception',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    passList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blueGrey[400],
        foregroundColor: Colors.white,
        child: Icon(FirstDownSelected ? Icons.check : Icons.all_out,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        '1st Down',
        style: new TextStyle(
            color: Colors.blueGrey[400]),
      ),
      selected: FirstDownSelected,
      onSelected: (selected) => setState(
              () => FirstDownSelected = selected),
    ));
    return passList;
  }

  List<Widget> _getRunList() {
    var runList = new List<Widget>();
    runList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Turnover',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    runList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.white,
        child: Icon(SackSelected ? Icons.check :  Icons.arrow_drop_up), // new Text('2'),
      ),
      label: new Text(
        'Fumble',
        style: new TextStyle(color: Colors.blue),
      ),
      selected: SackSelected,
      onSelected: (selected) => setState(
              () => SackSelected = selected),
    ));
    runList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.blueGrey[400],
        foregroundColor: Colors.white,
        child: Icon(FirstDownSelected ? Icons.check : Icons.all_out,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        '1st Down',
        style: new TextStyle(
            color: Colors.blueGrey[400]),
      ),
      selected: FirstDownSelected,
      onSelected: (selected) => setState(
              () => FirstDownSelected = selected),
    ));
    return runList;
  }

  List<Widget> _getDefaultList() {
    var defList = new List<Widget>();
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(RunSelected ? Icons.check : Icons.directions_run,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Run',
        style: new TextStyle(color: Colors.grey),
      ),
      selected: RunSelected,
      onSelected: (selected) =>
          setState(() => RunSelected = selected && (PlayTypeSelected = true)),
    ));
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon(
            PassSelected
                ? Icons.check
                : Icons.directions_walk,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Pass',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: PassSelected,
      onSelected: (selected) =>
          setState(() => PassSelected = selected && (PlayTypeSelected = true)),
    ),);
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( PlayactionSelected
            ? Icons.check
            : Icons.device_hub,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Play action',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: PlayactionSelected,
      onSelected: (selected) => setState(
            () => PlayactionSelected = selected && (PlayTypeSelected = true), // ,
      ),
    ),);
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( KickPuntSelected
            ? Icons.check
            : Icons.device_unknown,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Kick/Punt Return',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: KickPuntSelected,
      onSelected: (selected) => setState(
            () => KickPuntSelected = selected && (PlayTypeSelected = true), // ,
      ),
    ),);
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( KickSelected
            ? Icons.check
            : Icons.device_unknown,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Kick',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: KickSelected,
      onSelected: (selected) => setState(
            () => KickSelected = selected && (PlayTypeSelected = true), // ,
      ),
    ),);
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( KickPuntSelected
            ? Icons.check
            : Icons.device_unknown,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Punt',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: PuntSelected,
      onSelected: (selected) => setState(
            () => PuntSelected = selected && (PlayTypeSelected = true), // ,
      ),
    ),);
    defList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon( KickPuntSelected
            ? Icons.check
            : Icons.device_unknown,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Field goal',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: FieldGoalSelected,
      onSelected: (selected) => setState(
            () => FieldGoalSelected = selected && (PlayTypeSelected = true), // ,
      ),
    ),);
    return defList;
  }

  List<Widget> _getBlockList() {
    var blockList = new List<Widget>();
    blockList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        child: Icon(RunSelected ? Icons.check : Icons.directions_run,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Loss',
        style: new TextStyle(color: Colors.grey),
      ),
      selected: RunSelected,
      onSelected: (selected) =>
          setState(() => RunSelected = selected && (PlayTypeSelected = true)),
    ));
    blockList.add(new ChoiceChip(
      disabledColor: Colors.blueGrey,
      selectedColor: Colors.grey[350],
      backgroundColor: Colors.grey[200],
      labelPadding: EdgeInsets.all(4.0),
      avatar: new CircleAvatar(
        backgroundColor: Colors.brown[200],
        foregroundColor: Colors.white,
        child: Icon(
            PassSelected
                ? Icons.check
                : Icons.directions_walk,
            color: Colors.black), // new Text('2'),
      ),
      label: new Text(
        'Recovered',
        style:
        new TextStyle(color: Colors.brown[200]),
      ),
      selected: PassSelected,
      onSelected: (selected) =>
          setState(() => PassSelected = selected && (PlayTypeSelected = true)),
    ),);
    return blockList;
  }
}


