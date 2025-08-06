part of weather_forecasting;

class CurrentExtraData extends StatelessWidget {
  final CurrentWeather currentWeather;
  const CurrentExtraData(this.currentWeather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(CupertinoIcons.wind, color: Colors.white),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "${currentWeather.wind.speed} Km/h",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Wind",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black54,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.drop, color: Colors.white),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "${currentWeather.main.humidity} %",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Humidity",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black54,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.cloud_rain, color: Colors.white),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "${currentWeather.clouds} %",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Rain",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black54,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CurrentExtraDataShimmer extends StatelessWidget {
  const CurrentExtraDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue[300]!,
      highlightColor: Colors.blue[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (_) => _buildShimmerColumn()),
      ),
    );
  }

  Widget _buildShimmerColumn() {
    return Column(
      children: [
        Container(
          width: getProportionateScreenHeight(28),
          height: getProportionateScreenHeight(28),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),

        Container(
          width: getProportionateScreenWidth(60),
          height: getProportionateScreenHeight(16),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),

        Container(
          width: getProportionateScreenWidth(50),
          height: getProportionateScreenHeight(14),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
