import 'package:flutter/material.dart';
import 'package:flutter_app_component/debug/logger/log_console.dart';
import 'package:logger/logger.dart';

/// @author jd

class LogConsole extends StatefulWidget {
  final bool dark;

  const LogConsole({
    this.dark = false,
  });

  @override
  _LogConsoleState createState() => _LogConsoleState();
}

class _LogConsoleState extends State<LogConsole> {
  MyOutputCallback _callback;

  List<RenderedEvent> _filteredBuffer = [];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _filterController = TextEditingController();

  Level _filterLevel = Level.verbose;
  double _logFontSize = 14;

  bool _scrollListenerEnabled = true;
  bool _followBottom = true;

  @override
  void initState() {
    super.initState();

    _callback = (e) {
      Future.delayed(const Duration(milliseconds: 0), () {
        _refreshFilter();
      });
    };

    //add callback
    UIAndConsoleOutput.instance.addOutputListener(_callback);

    _scrollController.addListener(() {
      if (!_scrollListenerEnabled) return;
      final bool scrolledToBottom = _scrollController.offset >=
          _scrollController.position.maxScrollExtent;
      setState(() {
        _followBottom = scrolledToBottom;
      });
    });

    Future.delayed(const Duration(milliseconds: 0), () {
      _refreshFilter();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _refreshFilter() {
    final List newFilteredBuffer =
        UIAndConsoleOutput.instance.renderedBuffer.where((it) {
      var logLevelMatches = it.level.index >= _filterLevel.index;
      if (!logLevelMatches) {
        return false;
      } else if (_filterController.text.isNotEmpty) {
        var filterText = _filterController.text.toLowerCase();
        return it.lowerCaseText.contains(filterText);
      } else {
        return true;
      }
    }).toList();
    setState(() {
      _filteredBuffer = newFilteredBuffer as List<RenderedEvent>;
    });

    if (_followBottom) {
      Future.delayed(Duration.zero, _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTopBar(),
            Expanded(
              child: _buildLogContent(),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _followBottom ? 0 : 1,
        duration: Duration(milliseconds: 150),
        child: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            mini: true,
            clipBehavior: Clip.antiAlias,
            child: Icon(
              Icons.arrow_downward,
              color: widget.dark ? Colors.white : Colors.lightBlue[900],
            ),
            onPressed: _scrollToBottom,
          ),
        ),
      ),
    );
  }

  Widget _buildLogContent() {
    return Container(
      color: widget.dark ? Colors.black : Colors.grey[150],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1600,
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (context, index) {
              var logEntry = _filteredBuffer[index];
              return Text.rich(
                logEntry.span,
                key: Key(logEntry.id.toString()),
                style: TextStyle(fontSize: _logFontSize),
              );
            },
            itemCount: _filteredBuffer.length,
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return LogBar(
      dark: widget.dark,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Log Console",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _logFontSize++;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                _logFontSize--;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: LogBar(
        dark: widget.dark,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: _filterController,
                  onChanged: (s) => _refreshFilter(),
                  decoration: const InputDecoration(
                    labelText: 'Filter log output',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            DropdownButton<Level>(
              value: _filterLevel,
              items: const [
                DropdownMenuItem<Level>(
                  child: Text('VERBOSE'),
                  value: Level.verbose,
                ),
                DropdownMenuItem<Level>(
                  child: Text('DEBUG'),
                  value: Level.debug,
                ),
                DropdownMenuItem<Level>(
                  child: Text('INFO'),
                  value: Level.info,
                ),
                DropdownMenuItem<Level>(
                  child: Text('WARNING'),
                  value: Level.warning,
                ),
                DropdownMenuItem<Level>(
                  child: Text('ERROR'),
                  value: Level.error,
                ),
                DropdownMenuItem<Level>(
                  child: Text('WTF'),
                  value: Level.wtf,
                )
              ],
              onChanged: (value) {
                _filterLevel = value;
                _refreshFilter();
              },
            )
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() async {
    _scrollListenerEnabled = false;

    setState(() {
      _followBottom = true;
    });

    final ScrollPosition scrollPosition = _scrollController.position;
    await _scrollController.animateTo(
      scrollPosition.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );

    _scrollListenerEnabled = true;
  }

  @override
  void didUpdateWidget(covariant LogConsole oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    UIAndConsoleOutput.instance.removeOutputListener();
    super.dispose();
  }
}

class LogBar extends StatelessWidget {
  final bool dark;
  final Widget child;

  const LogBar({this.dark, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            if (!dark)
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 3,
              ),
          ],
        ),
        child: Material(
          color: dark ? Colors.blueGrey[900] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: child,
          ),
        ),
      ),
    );
  }
}
