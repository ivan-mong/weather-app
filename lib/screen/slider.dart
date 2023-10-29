import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/bloc/additional_info/additional_info_bloc.dart';
import 'package:weather_app/core/model/weather.dart';
import 'package:intl/intl.dart';

class ImageSlider extends StatelessWidget {
  final List<DailyWeather> weathers;
  AdditionalInfoBloc additionalInfoBloc;
  ImageSlider({required this.weathers, super.key})
      : additionalInfoBloc = AdditionalInfoBloc()
          ..add(
            UpdateAdditionalInfo(
              humidity: weathers[0].humidity,
              temperature: weathers[0].temperature,
            ),
          );

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = weathers
        .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(matchedWeatherImg(item.mainWeather),
                      fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        "${DateFormat('EEEE').format(
                              Jiffy.now()
                                  .add(days: weathers.indexOf(item))
                                  .dateTime,
                            )} ${DateFormat('Md').format(
                              Jiffy.now()
                                  .add(days: weathers.indexOf(item))
                                  .dateTime,
                            )}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ))
        .toList();
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              additionalInfoBloc.add(
                UpdateAdditionalInfo(
                  humidity: weathers[index].humidity,
                  temperature: weathers[index].temperature,
                ),
              );
            },
          ),
          items: imageSliders,
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
          bloc: additionalInfoBloc,
          builder: (context, state) {
            if (state is AdditionalInfoUpdated) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Temperature"),
                      Text("${state.temperature}°C")
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Humidity"),
                      Text("${state.humidity}%")
                    ],
                  ),
                ],
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}

String matchedWeatherImg(String weather) {
  switch (weather) {
    case 'Snow':
      return "https://media3.giphy.com/media/7Bgpw7PwdxoDC/giphy.gif?cid=ecf05e47t1trkp8e72uu4zegx6m4ilev2111eldwcnou3xtp&ep=v1_gifs_search&rid=giphy.gif&ct=g";
    case 'Rain':
      return "https://media2.giphy.com/media/l0Iy5fjHyedk9aDGU/giphy.gif?cid=ecf05e47crlokijz4kgjxq00606xkhk1okk8trfp6jbmdagk&ep=v1_gifs_search&rid=giphy.gif&ct=g";
    case 'Clouds':
      return "https://media0.giphy.com/media/GFXNdR1tuMopi/giphy.gif?cid=ecf05e476yxt0vgisxq1lfx9i2id6dylqum0jt8yb3dy6bnz&ep=v1_gifs_search&rid=giphy.gif&ct=g";
    default:
      return "https://media4.giphy.com/media/o7R0zQ62m8Nk4/giphy.gif?cid=ecf05e47e8i5m5p3dr8sf4kbydh6xzn91dvoymli0fekveav&ep=v1_gifs_search&rid=giphy.gif&ct=g";
  }
}
