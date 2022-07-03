import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:place_picker/helpers/localization/get_response_phrases_model.dart';
import 'package:place_picker/helpers/localization/locale.dart';
import 'package:place_picker/helpers/localization/response_phrases_model.dart';
import 'package:place_picker/helpers/size_config.dart';
import 'package:place_picker/models/fetched_address_model.dart';

class AddressLabel extends StatelessWidget {
  const AddressLabel(
      {required this.address,
      required this.loading,
      required this.onTap,
      required this.loader,
      required this.notConnected,
      this.done,
      this.error,
      this.mapLocale = MapLocale.english,
      Key? key})
      : super(key: key);
  final CompleteAddress address;
  final bool loading;
  final bool notConnected;
  final Widget loader;
  final Function(CompleteAddress) onTap;
  final Widget? done;
  final Widget? error;
  final MapLocale mapLocale;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.height30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.radius20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: SizeConfig.width10, sigmaY: SizeConfig.height10),
            child: Container(
              alignment: Alignment.center,
              width: SizeConfig.width200,
              height: SizeConfig.height200 + SizeConfig.height200,
              padding: EdgeInsets.all(SizeConfig.width20),
              decoration: BoxDecoration(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.black.withOpacity(0.25)
                        : Colors.white.withOpacity(0.25),
              ),
              child: loading
                  ? loader
                  : Column(
                      children: <Widget>[
                        notConnected
                            ? Text(
                                '${getResponsePhrase(ResponsePhrasesModel.noInternetConnection, mapLocale.locale)}\n${getResponsePhrase(ResponsePhrasesModel.tryAgain, mapLocale.locale)}',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                textScaleFactor: 1.0,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizeConfig.font20,
                                  color: MediaQuery.of(context)
                                              .platformBrightness !=
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              )
                            : Text(
                                address.completeAddress!,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                textScaleFactor: 1.0,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizeConfig.font15,
                                  color: MediaQuery.of(context)
                                              .platformBrightness !=
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            onTap(address);
                            Navigator.of(context).pop();
                          },
                          child: notConnected
                              ? error ??
                                  CircleAvatar(
                                    backgroundColor: notConnected
                                        ? Colors.red.withOpacity(0.35)
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.35),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                      size: SizeConfig.width30,
                                    ),
                                  )
                              : done ??
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.35),
                                    child: Icon(
                                      Icons.check,
                                      color: Theme.of(context).primaryColor,
                                      size: SizeConfig.width30,
                                    ),
                                  ),
                        ),
                        const Spacer()
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
