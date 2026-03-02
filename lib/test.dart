import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    width: 402,
    height: 874,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 47,
                top: 151,
                child: SizedBox(
                    width: 308,
                    height: 27,
                    child: Text(
                        'Danh sách thành viên',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFF00ACB1),
                            fontSize: 30,
                            fontFamily: 'Sarala',
                            fontWeight: FontWeight.w700,
                            height: 0.73,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 211,
                child: Container(
                    width: 347,
                    height: 103,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 347,
                                    height: 103,
                                    decoration: ShapeDecoration(
                                        color: const Color(0xFF87E4DB),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFF0F0F0),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        shadows: [
                                            BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                                spreadRadius: 0,
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 28,
                                top: 18,
                                child: Container(
                                    width: 215,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 16,
                                        children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Container(
                                                        width: 64,
                                                        height: 64,
                                                        padding: const EdgeInsets.all(4),
                                                        decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(9999),
                                                            ),
                                                        ),
                                                        child: Stack(
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child: Container(
                                                                        width: 64,
                                                                        height: 64,
                                                                        decoration: ShapeDecoration(
                                                                            color: Colors.white.withValues(alpha: 0),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                            shadows: [
                                                                                BoxShadow(
                                                                                    color: Color(0x19000000),
                                                                                    blurRadius: 4,
                                                                                    offset: Offset(0, 2),
                                                                                    spreadRadius: -2,
                                                                                ),BoxShadow(
                                                                                    color: Color(0x19000000),
                                                                                    blurRadius: 6,
                                                                                    offset: Offset(0, 4),
                                                                                    spreadRadius: -1,
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ),
                                                                ),
                                                                Expanded(
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        clipBehavior: Clip.antiAlias,
                                                                        decoration: ShapeDecoration(
                                                                            image: DecorationImage(
                                                                                image: NetworkImage("https://placehold.co/56x56"),
                                                                                fit: BoxFit.fill,
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            Container(
                                                width: 135,
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 4,
                                                    children: [
                                                        Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                SizedBox(
                                                                    width: 156,
                                                                    height: 28,
                                                                    child: Text(
                                                                        'Lê Văn Huy (Bố)',
                                                                        style: TextStyle(
                                                                            color: const Color(0xFF111827),
                                                                            fontSize: 20,
                                                                            fontFamily: 'Public Sans',
                                                                            fontWeight: FontWeight.w700,
                                                                            height: 1.40,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                        Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                            decoration: ShapeDecoration(
                                                                color: Colors.white.withValues(alpha: 0.80),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(9999),
                                                                ),
                                                                shadows: [
                                                                    BoxShadow(
                                                                        color: Color(0x0C000000),
                                                                        blurRadius: 2,
                                                                        offset: Offset(0, 1),
                                                                        spreadRadius: 0,
                                                                    )
                                                                ],
                                                            ),
                                                            child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                spacing: 6,
                                                                children: [
                                                                    Container(
                                                                        width: 8,
                                                                        height: 8,
                                                                        decoration: ShapeDecoration(
                                                                            color: const Color(0xFFEAB308),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            SizedBox(
                                                                                width: 77.64,
                                                                                height: 20,
                                                                                child: Text(
                                                                                    'Đang đi dạo',
                                                                                    style: TextStyle(
                                                                                        color: const Color(0xFF374151),
                                                                                        fontSize: 14,
                                                                                        fontFamily: 'Public Sans',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 1.43,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 230,
                                top: 52,
                                child: Container(
                                    width: 68,
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: ShapeDecoration(
                                        color: Colors.white.withValues(alpha: 0.80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                        ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4,
                                        children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 18,
                                                        height: 28,
                                                        child: Text(
                                                            'battery_alert',
                                                            style: TextStyle(
                                                                color: const Color(0xFFCA8A04),
                                                                fontSize: 18,
                                                                fontFamily: 'Material Icons Round',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.56,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 30.58,
                                                        height: 20,
                                                        child: Text(
                                                            '24%',
                                                            style: TextStyle(
                                                                color: const Color(0xFF4B5563),
                                                                fontSize: 14,
                                                                fontFamily: 'Public Sans',
                                                                fontWeight: FontWeight.w600,
                                                                height: 1.43,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 327,
                child: Container(
                    width: 347,
                    height: 103,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 347,
                                    height: 103,
                                    decoration: ShapeDecoration(
                                        color: const Color(0xFF87E4DB),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFF0F0F0),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        shadows: [
                                            BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                                spreadRadius: 0,
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 28,
                                top: 18,
                                child: Container(
                                    width: 215,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 16,
                                        children: [
                                            Container(
                                                width: 64,
                                                height: 64,
                                                padding: const EdgeInsets.all(4),
                                                decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(9999),
                                                    ),
                                                ),
                                                child: Stack(
                                                    children: [
                                                        Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                                width: 64,
                                                                height: 64,
                                                                decoration: ShapeDecoration(
                                                                    color: Colors.white.withValues(alpha: 0),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(9999),
                                                                    ),
                                                                    shadows: [
                                                                        BoxShadow(
                                                                            color: Color(0x19000000),
                                                                            blurRadius: 4,
                                                                            offset: Offset(0, 2),
                                                                            spreadRadius: -2,
                                                                        ),BoxShadow(
                                                                            color: Color(0x19000000),
                                                                            blurRadius: 6,
                                                                            offset: Offset(0, 4),
                                                                            spreadRadius: -1,
                                                                        )
                                                                    ],
                                                                ),
                                                            ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                width: double.infinity,
                                                                clipBehavior: Clip.antiAlias,
                                                                decoration: ShapeDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage("https://placehold.co/56x56"),
                                                                        fit: BoxFit.fill,
                                                                    ),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(9999),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            Container(
                                                width: 135,
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 4,
                                                    children: [
                                                        Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                SizedBox(
                                                                    width: 156,
                                                                    height: 28,
                                                                    child: Text(
                                                                        'Như Quỳnh (Mẹ)',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 20,
                                                                            fontFamily: 'Public Sans',
                                                                            fontWeight: FontWeight.w700,
                                                                            height: 1.40,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                        Container(
                                                            width: 115,
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                            decoration: ShapeDecoration(
                                                                color: Colors.white.withValues(alpha: 0.80),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(9999),
                                                                ),
                                                                shadows: [
                                                                    BoxShadow(
                                                                        color: Color(0x0C000000),
                                                                        blurRadius: 2,
                                                                        offset: Offset(0, 1),
                                                                        spreadRadius: 0,
                                                                    )
                                                                ],
                                                            ),
                                                            child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                spacing: 6,
                                                                children: [
                                                                    Container(
                                                                        width: 8,
                                                                        height: 8,
                                                                        decoration: ShapeDecoration(
                                                                            color: const Color(0xFF04B8BA),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            SizedBox(
                                                                                width: 77.64,
                                                                                height: 20,
                                                                                child: Text(
                                                                                    'Đang ở nhà',
                                                                                    style: TextStyle(
                                                                                        color: const Color(0xFF374151),
                                                                                        fontSize: 14,
                                                                                        fontFamily: 'Public Sans',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 1.43,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 231,
                                top: 52,
                                child: Container(
                                    width: 68,
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: ShapeDecoration(
                                        color: Colors.white.withValues(alpha: 0.80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                        ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4,
                                        children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 18,
                                                        height: 28,
                                                        child: Text(
                                                            'battery_full',
                                                            style: TextStyle(
                                                                color: const Color(0xFF00ADB2),
                                                                fontSize: 18,
                                                                fontFamily: 'Material Icons Round',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.56,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 31.41,
                                                        height: 20,
                                                        child: Text(
                                                            '85%',
                                                            style: TextStyle(
                                                                color: const Color(0xFF4B5563),
                                                                fontSize: 14,
                                                                fontFamily: 'Public Sans',
                                                                fontWeight: FontWeight.w600,
                                                                height: 1.43,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 443,
                child: Container(
                    width: 347,
                    height: 103,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 347,
                                    height: 103,
                                    decoration: ShapeDecoration(
                                        color: const Color(0xFF87E4DB),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFF0F0F0),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        shadows: [
                                            BoxShadow(
                                                color: Color(0x19000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                                spreadRadius: 0,
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 28,
                                top: 18,
                                child: Container(
                                    width: 215,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 16,
                                        children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Container(
                                                        width: 64,
                                                        height: 64,
                                                        padding: const EdgeInsets.all(4),
                                                        decoration: ShapeDecoration(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(9999),
                                                            ),
                                                        ),
                                                        child: Stack(
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child: Container(
                                                                        width: 64,
                                                                        height: 64,
                                                                        decoration: ShapeDecoration(
                                                                            color: Colors.white.withValues(alpha: 0),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                            shadows: [
                                                                                BoxShadow(
                                                                                    color: Color(0x19000000),
                                                                                    blurRadius: 4,
                                                                                    offset: Offset(0, 2),
                                                                                    spreadRadius: -2,
                                                                                ),BoxShadow(
                                                                                    color: Color(0x19000000),
                                                                                    blurRadius: 6,
                                                                                    offset: Offset(0, 4),
                                                                                    spreadRadius: -1,
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ),
                                                                ),
                                                                Expanded(
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        clipBehavior: Clip.antiAlias,
                                                                        decoration: ShapeDecoration(
                                                                            image: DecorationImage(
                                                                                image: NetworkImage("https://placehold.co/56x56"),
                                                                                fit: BoxFit.fill,
                                                                            ),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            Container(
                                                width: 135,
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    spacing: 4,
                                                    children: [
                                                        Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                SizedBox(
                                                                    width: 167,
                                                                    height: 28,
                                                                    child: Text(
                                                                        'Lê Như Kha (Em)',
                                                                        style: TextStyle(
                                                                            color: const Color(0xFF111827),
                                                                            fontSize: 20,
                                                                            fontFamily: 'Public Sans',
                                                                            fontWeight: FontWeight.w700,
                                                                            height: 1.40,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                        Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                            decoration: ShapeDecoration(
                                                                color: Colors.white.withValues(alpha: 0.80),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(9999),
                                                                ),
                                                                shadows: [
                                                                    BoxShadow(
                                                                        color: Color(0x0C000000),
                                                                        blurRadius: 2,
                                                                        offset: Offset(0, 1),
                                                                        spreadRadius: 0,
                                                                    )
                                                                ],
                                                            ),
                                                            child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                spacing: 6,
                                                                children: [
                                                                    Container(
                                                                        width: 8,
                                                                        height: 8,
                                                                        decoration: ShapeDecoration(
                                                                            color: const Color(0xFFFF0000),
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(9999),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            SizedBox(
                                                                                width: 77.64,
                                                                                height: 20,
                                                                                child: Text(
                                                                                    'Không rõ',
                                                                                    style: TextStyle(
                                                                                        color: const Color(0xFF374151),
                                                                                        fontSize: 14,
                                                                                        fontFamily: 'Public Sans',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        height: 1.43,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 230,
                                top: 52,
                                child: Container(
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: ShapeDecoration(
                                        color: Colors.white.withValues(alpha: 0.80),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(24),
                                        ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 4,
                                        children: [
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 18,
                                                        height: 28,
                                                        child: Text(
                                                            'battery_alert',
                                                            style: TextStyle(
                                                                color: const Color(0xFFFF0000),
                                                                fontSize: 18,
                                                                fontFamily: 'Material Icons Round',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.56,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    SizedBox(
                                                        width: 30.58,
                                                        height: 20,
                                                        child: Text(
                                                            '24%',
                                                            style: TextStyle(
                                                                color: const Color(0xFF4B5563),
                                                                fontSize: 14,
                                                                fontFamily: 'Public Sans',
                                                                fontWeight: FontWeight.w600,
                                                                height: 1.43,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: -18,
                top: -5,
                child: Container(
                    width: 438,
                    padding: const EdgeInsets.only(
                        top: 21,
                        left: 24,
                        right: 24,
                        bottom: 19,
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 154,
                        children: [
                            Expanded(
                                child: Container(
                                    height: 22,
                                    padding: const EdgeInsets.only(top: 1.50),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 10,
                                        children: [
                                            Text(
                                                '9:41',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black /* Labels-Primary */,
                                                    fontSize: 17,
                                                    fontFamily: 'SF Pro',
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.29,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Expanded(
                                child: Container(
                                    height: 22,
                                    padding: const EdgeInsets.only(top: 1, right: 1),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 7,
                                        children: [
                                            Container(
                                                width: 27.33,
                                                height: 13,
                                                child: Stack(
                                                    children: [
                                                        Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Opacity(
                                                                opacity: 0.35,
                                                                child: Container(
                                                                    width: 25,
                                                                    height: 13,
                                                                    decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                width: 1,
                                                                                color: Colors.black /* Labels-Primary */,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(4.30),
                                                                        ),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                        Positioned(
                                                            left: 2,
                                                            top: 2,
                                                            child: Container(
                                                                width: 21,
                                                                height: 9,
                                                                decoration: ShapeDecoration(
                                                                    color: Colors.black /* Labels-Primary */,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(2.50),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 21,
                top: 68,
                child: Container(
                    width: 357,
                    height: 58,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 70,
                                top: 5,
                                child: Container(
                                    width: 220,
                                    height: 49,
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100),
                                        ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Expanded(
                                                child: Container(
                                                    padding: const EdgeInsets.all(11),
                                                    decoration: ShapeDecoration(
                                                        color: const Color(0xFF87E4DB),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(100),
                                                        ),
                                                    ),
                                                    child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                            Expanded(
                                                                child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    spacing: 8,
                                                                    children: [
                                                                        Text(
                                                                            '􀊫',
                                                                            style: TextStyle(
                                                                                color: const Color(0xFF333333) /* Labels---Vibrant-Primary */,
                                                                                fontSize: 17,
                                                                                fontFamily: 'SF Pro',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.29,
                                                                                letterSpacing: -0.08,
                                                                            ),
                                                                        ),
                                                                        Text(
                                                                            'Tìm thành viên',
                                                                            style: TextStyle(
                                                                                color: const Color(0x993C3C43) /* Labels-Secondary */,
                                                                                fontSize: 17,
                                                                                fontFamily: 'SF Pro',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.29,
                                                                                letterSpacing: -0.08,
                                                                            ),
                                                                        ),
                                                                    ],
                                                                ),
                                                            ),
                                                            Text(
                                                                '􀊱',
                                                                style: TextStyle(
                                                                    color: const Color(0xFF333333) /* Labels---Vibrant-Primary */,
                                                                    fontSize: 17,
                                                                    fontFamily: 'SF Pro',
                                                                    fontWeight: FontWeight.w400,
                                                                    height: 1.29,
                                                                    letterSpacing: -0.08,
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 58,
                                    height: 58,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(),
                                ),
                            ),
                            Positioned(
                                left: 302,
                                top: 1,
                                child: Container(
                                    width: 55,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(),
                                    child: Stack(),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
),
    );
  }
}