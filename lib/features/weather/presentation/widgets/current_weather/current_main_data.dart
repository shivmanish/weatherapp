part of weather_forecasting;

class CurrentMainData extends StatelessWidget {
  final CurrentWeather currentWeather;
  const CurrentMainData(this.currentWeather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(30)),
        Image(
          image: AssetImage(currentWeather.image),
          width: getProportionateScreenWidth(250),
          height: getProportionateScreenHeight(250),
          fit: BoxFit.fill,
        ),
        Center(
          child: Column(
            children: [
              text(120, currentWeather.main.temp.toString(), context),
              /* + "\u00B0"*/
              text(25, currentWeather.weather.first.main, context),
              text(18, currentWeather.day, context),
            ],
          ),
        ),
      ],
    );
  }

  Widget text(double height, String text, BuildContext ctx) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(ctx).colorScheme.surface,
        decoration: TextDecoration.none,
        fontSize: getProportionateScreenHeight(height),
      ),
    );
  }
}

class CurrentMainDataShimmer extends StatelessWidget {
  const CurrentMainDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[300]!,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          // Image placeholder
          Container(
            width: getProportionateScreenWidth(200),
            height: getProportionateScreenHeight(200),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          // Text placeholders
          shimmerTextBlock(getProportionateScreenHeight(120), 160),
          SizedBox(height: getProportionateScreenHeight(10)),
          shimmerTextBlock(getProportionateScreenHeight(25), 100),
          SizedBox(height: getProportionateScreenHeight(5)),
          shimmerTextBlock(getProportionateScreenHeight(18), 80),
        ],
      ),
    );
  }

  Widget shimmerTextBlock(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
