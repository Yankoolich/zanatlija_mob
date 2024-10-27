import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zanatlija_app/data/models/craft.dart';
import 'package:zanatlija_app/navigation/router.gr.dart';

class CraftWidget extends StatelessWidget {
  final bool? smallerSize;
  final Craft craft;
  const CraftWidget(this.craft, {this.smallerSize, super.key});

  @override
  Widget build(BuildContext context) {
    final containerHeight = smallerSize == true
        ? MediaQuery.of(context).size.height * 0.2
        : MediaQuery.of(context).size.height * 0.235;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        height: containerHeight,
        width: MediaQuery.of(context).size.width * 0.635,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: MediaQuery.of(context).size.height * 0.235,
              width: MediaQuery.of(context).size.width * 0.635,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          craft.imageUrl != null
                              ? Image.network(
                                  craft.imageUrl!,
                                  width: 30,
                                  fit: BoxFit.fill,
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                craft.craftName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 17.5,
                                ),
                              ),
                              Text(
                                craft.craftsmanName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff888888),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Cena po satu:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff888888),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${craft.price} €",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff292929),
                                  fontSize: 29,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            width: 20,
                            color: Color(0xff888888),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Lokacija:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff888888),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                craft.location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff292929),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/hammerWrench.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${craft.rate ?? 0.0}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 29,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.1,
                alignment: const AlignmentDirectional(1.05, -1.05),
                decoration: BoxDecoration(
                    border: const Border(
                      left: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    ),
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          40,
                        ),
                        topRight: Radius.circular(0))),
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(ViewCraft(craft: craft));
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
