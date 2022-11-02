import 'package:flutter/material.dart';

Widget myContactContainer(
        String imgSrc, String title, String details, VoidCallback action) =>
    Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(children: [
          Image.asset(
            imgSrc,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ),
              Flexible(
                child: InkWell(
                  onTap: action,
                  child: Text(details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
