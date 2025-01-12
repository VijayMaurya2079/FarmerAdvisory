import 'package:farmer/import.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBServices.call.weather("Lucknow"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data.toString().contains("error")) {
            return const SizedBox();
          }
          final current = snapshot.data["current"];

          return Row(
            children: [
              Image.network(
                current["condition"]["icon"]
                    .toString()
                    .replaceFirst("//", "https://"),
                width: 40,
              ),
              // Icon(
              //   getIcon(
              //     current["is_day"].toString(),
              //     current["weather_descriptions"][0].toString(),
              //   ),
              //   color: Colors.purple,
              // ),
              SizedBox(width: 2.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${current["temp_c"]}\u00B0",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "${current["condition"]["text"]}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          );
        }
        return const Text("");
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return AppContainer(
  //     appBar: AppBar(title: const Text("Weather")),
  //     child: FutureBuilder(
  //       future: DBServices.call.weather("Lucknow"),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done &&
  //             snapshot.hasData) {
  //           final location = snapshot.data["location"];
  //           final current = snapshot.data["current"];

  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   "${location["name"]},${location["region"]},${location["country"]}",
  //                   style: TextStyle(
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     const Icon(Icons.timelapse_rounded),
  //                     const SizedBox(width: 10),
  //                     Text(
  //                       "${location["localtime"]}",
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 8.h),
  //                 Icon(
  //                   getIcon(
  //                     current["is_day"].toString(),
  //                     current["weather_descriptions"][0].toString(),
  //                   ),
  //                   size: 120.sp,
  //                   color: Colors.purple,
  //                 ),
  //                 SizedBox(height: 5.h),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       "${current["temperature"]}\u00B0",
  //                       style: TextStyle(
  //                         fontSize: 35.sp,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.blue,
  //                       ),
  //                     ),
  //                     Text(
  //                       "${current["weather_descriptions"][0]}",
  //                       style: TextStyle(fontSize: 14.sp),
  //                     ),
  //                   ],
  //                 ),
  //                 Text.rich(
  //                   TextSpan(children: [
  //                     const TextSpan(text: "Humidity"),
  //                     const TextSpan(text: " "),
  //                     TextSpan(
  //                       text: "${current["humidity"]}",
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                       ),
  //                     ),
  //                   ]),
  //                 ),
  //                 Text.rich(
  //                   TextSpan(children: [
  //                     const TextSpan(text: "Wind Speed"),
  //                     const TextSpan(text: " "),
  //                     TextSpan(
  //                       text: "${current["wind_speed"]}",
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                       ),
  //                     ),
  //                     const TextSpan(text: " "),
  //                     const TextSpan(text: "Kilometers/Hour"),
  //                   ]),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //         return const Text("");
  //       },
  //     ),
  //   );
  // }

  IconData getIcon(String isDay, String weather) {
    if (isDay == "Yes") {
      if (weather == "sunny") {
        return WeatherIcons.day_sunny;
      } else if (weather == "fog") {
        return WeatherIcons.day_fog;
      } else if (weather == "rain") {
        return WeatherIcons.rain;
      } else if (weather == "sleet") {
        return WeatherIcons.sleet;
      } else if (weather == "snow-wind") {
        return WeatherIcons.snow_wind;
      } else if (weather == "thunderstorm") {
        return WeatherIcons.thunderstorm;
      } else if (weather == "cloudy-high") {
        return WeatherIcons.day_cloudy_high;
      } else if (weather == "cloudy") {
        return WeatherIcons.cloudy;
      } else if (weather == "hail") {
        return WeatherIcons.hail;
      } else if (weather == "rain-mix") {
        return WeatherIcons.rain_mix;
      } else if (weather == "sleet-storm") {
        return WeatherIcons.sleet;
      } else if (weather == "sprinkle") {
        return WeatherIcons.sprinkle;
      } else if (weather == "windy") {
        return WeatherIcons.wind;
      } else if (weather == "light-wind") {
        return WeatherIcons.day_light_wind;
      } else if (weather == "cloudy-gusts") {
        return WeatherIcons.cloudy_gusts;
      } else if (weather == "haze") {
        return WeatherIcons.day_haze;
      } else if (weather == "rain-wind") {
        return WeatherIcons.rain_wind;
      } else if (weather == "snow") {
        return WeatherIcons.snow;
      } else if (weather == "storm-showers") {
        return WeatherIcons.storm_showers;
      } else if (weather == "cloudy-windy") {
        return WeatherIcons.cloudy_windy;
      } else if (weather == "lightning") {
        return WeatherIcons.lightning;
      } else if (weather == "showers") {
        return WeatherIcons.showers;
      } else if (weather == "snow-thunderstorm") {
        return WeatherIcons.day_snow_thunderstorm;
      } else if (weather == "sunny-overcast") {
        return WeatherIcons.day_sunny_overcast;
      } else {
        return WeatherIcons.day_haze;
      }
    } else {
      if (weather == "fog") {
        return WeatherIcons.night_fog;
      } else if (weather == "rain") {
        return WeatherIcons.rain;
      } else if (weather == "sleet") {
        return WeatherIcons.sleet;
      } else if (weather == "snow-wind") {
        return WeatherIcons.snow_wind;
      } else if (weather == "thunderstorm") {
        return WeatherIcons.thunderstorm;
      } else if (weather == "cloudy-high") {
        return WeatherIcons.night_cloudy_high;
      } else if (weather == "cloudy") {
        return WeatherIcons.cloudy;
      } else if (weather == "hail") {
        return WeatherIcons.hail;
      } else if (weather == "rain-mix") {
        return WeatherIcons.rain_mix;
      } else if (weather == "sleet-storm") {
        return WeatherIcons.sleet;
      } else if (weather == "sprinkle") {
        return WeatherIcons.sprinkle;
      } else if (weather == "windy") {
        return WeatherIcons.wind;
      } else if (weather == "cloudy-gusts") {
        return WeatherIcons.cloudy_gusts;
      } else if (weather == "rain-wind") {
        return WeatherIcons.rain_wind;
      } else if (weather == "snow") {
        return WeatherIcons.snow;
      } else if (weather == "storm-showers") {
        return WeatherIcons.storm_showers;
      } else if (weather == "cloudy-windy") {
        return WeatherIcons.cloudy_windy;
      } else if (weather == "lightning") {
        return WeatherIcons.lightning;
      } else if (weather == "showers") {
        return WeatherIcons.showers;
      } else if (weather == "snow-thunderstorm") {
        return WeatherIcons.day_snow_thunderstorm;
      } else if (weather == "sunny-overcast") {
        return WeatherIcons.day_sunny_overcast;
      } else {
        return WeatherIcons.day_haze;
      }
    }
  }
}
