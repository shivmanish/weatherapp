part of weather_forecasting;

class SearchPage extends StatefulWidget {
  final void Function(LatLong?)? onPositionFetched;
  const SearchPage({super.key, this.onPositionFetched});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  final _searchTextController = TextEditingController();
  final ValueNotifier<bool> showSearchIcon = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isFocused = ValueNotifier<bool>(false);
  late final WeatherBloc bloc;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    bloc = getIt<WeatherBloc>();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final isKeyBoardOpened = View.of(context).viewInsets.bottom > 0;
    if (!isKeyBoardOpened) {
      _isFocused.value = false;
    } else {
      _isFocused.value = true;
    }
  }

  void _onSearchTextChanged(String searchTerm) async {
    if (searchTerm.length <= 3) {
      showSearchIcon.value = false;
      return;
    }
    showSearchIcon.value = true;
  }

  void _addEvent() {
    bloc.add(GetWeatherByCity(cityName: _searchTextController.text.trim()));
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 5),
      body: BlocProvider<WeatherBloc>(
        create: (context) => bloc,
        child: Column(
          children: [
            _searchWidget(),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: _fetchedWeatherBuilde(),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isFocused,
                    builder: (context, value, child) {
                      return value ? suggestionCities() : SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(15)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.sizeOf(context).width,
        height: kToolbarHeight * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: TextField(
          autofocus: true,
          controller: _searchTextController,
          textInputAction: TextInputAction.search,
          textCapitalization: TextCapitalization.words,
          cursorColor: Theme.of(context).hintColor,
          focusNode: _focusNode,
          decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: () {
                getIt<AppRouter>().pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            suffixIcon: ValueListenableBuilder<bool>(
              valueListenable: showSearchIcon,
              builder: (context, value, child) {
                return value
                    ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _addEvent,
                      color: Theme.of(context).hintColor,
                    )
                    : SizedBox();
              },
            ),
            border: InputBorder.none,
            hintText: 'Search city name...',
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
    );
  }

  Widget _fetchedWeatherBuilde() {
    return Column(
      children: [
        CurrentWeatherView(
          emptyWidget: Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            alignment: Alignment.center,
            child: ErrorOrEmptyContainer(
              message: 'Select or enter city name to fetch current data',
              forError: false,
            ),
          ),
          shouldGetWeatherData: false,
        ),
      ],
    );
  }

  Widget suggestionCities() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.25,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: ListView.builder(
        itemCount: famousCities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              famousCities[index].name,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {
              _searchTextController.text = famousCities[index].name;
              _addEvent();
            },
          );
        },
      ),
    );
  }
}
