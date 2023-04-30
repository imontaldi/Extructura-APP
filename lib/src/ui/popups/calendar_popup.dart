// Flutter imports:
import 'package:extructura_app/src/enums/culture.dart';
import 'package:extructura_app/src/managers/data_manager.dart';
import 'package:extructura_app/src/ui/components/buttons/rounded_button_component.dart';
import 'package:extructura_app/utils/extensions.dart';
import 'package:extructura_app/values/k_colors.dart';
import 'package:extructura_app/values/k_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

import '../components/common/calendar/calendar_all.dart';

// Project imports:

class CalendarPopup extends StatefulWidget {
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool enableRange;
  final bool enableYearSelection;
  final DateTime? selectDate;
  final String? titleCalendar;
  final String? titleYearSelect;
  final String? subTitleYearSelect;
  final String? buttonName;
  final String? subtitle;

  const CalendarPopup({
    Key? key,
    required this.minDate,
    required this.maxDate,
    required this.enableRange,
    this.enableYearSelection = true,
    required this.selectDate,
    required this.titleCalendar,
    this.titleYearSelect,
    this.subTitleYearSelect,
    this.buttonName,
    this.subtitle,
  }) : super(key: key);

  @override
  CalendarPopupState createState() => CalendarPopupState();
}

class CalendarPopupState extends State<CalendarPopup> {
  CalendarPopupState();

  //CalendarController _calendarController;
  final double width = 550;
  final double radius = 20;
  final int initYear = 1920;
  DateTime minDate = DateTime.now();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  DateTime? focusDay;
  List<AmountSelected> yearList = [];
  bool enableButton = false;
  bool tap = false;
  bool changedDate = false;
  bool tapYear = false;

  String locale = DataManager().getCulture() == Culture.es ? 'es_AR' : 'en_US';

  @override
  Widget build(BuildContext context) {
    return _dialog();
  }

  @override
  void initState() {
    //calendarController = CalendarController();
    minDate = widget.enableRange
        ? (widget.minDate ?? DateTime.now())
        : DateTime(initYear);
    if (!widget.enableRange && widget.selectDate != null) {
      selectedStartDate = DateTime(widget.selectDate!.year,
          widget.selectDate!.month, widget.selectDate!.day);
    }
    _generateYears();
    super.initState();
  }

  @override
  void didUpdateWidget(CalendarPopup oldWidget) {
    minDate = minDate;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, DateTime events) {
    tapYear = false;
    if (widget.enableRange) {
      // ignore: prefer_conditional_assignment
      if (selectedStartDate == null) {
        selectedStartDate = day;
        return;
      }
      if (selectedEndDate == null) {
        if (day.isBefore(selectedStartDate ?? minDate)) {
          selectedStartDate = day;
        } else {
          selectedEndDate = day;
        }
      } else {
        selectedStartDate = day;
        selectedEndDate = null;
      }
      return;
    } else {
      selectedStartDate = day;
      return;
    }
  }

  _dialog() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _background(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Container(
                width: width,
                child: _body(),
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _background() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        "images/background_popup.png",
        fit: BoxFit.fill,
        height: height,
        width: width,
      ),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        _content(),
        _buttonExit(),
      ],
    );
  }

  _content() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _title(),
          _subtitle(),
          const SizedBox(height: 15),
          _buildTableCalendar(),
          const SizedBox(height: 15),
          _buttonAccept(),
        ],
      ),
    );
  }

  _title() {
    return Center(
      child: Text(
        widget.titleCalendar ?? "",
        textAlign: TextAlign.center,
        softWrap: true,
        style: const TextStyle(
          color: KGrey,
          fontWeight: FontWeight.w400,
          fontSize: KFontSizeLarge40,
        ),
      ),
    );
  }

  _subtitle() {
    return widget.subtitle != null
        ? Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Center(
              child: Text(
                widget.subtitle ?? "",
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  color: KGrey,
                  fontSize: KFontSizeMedium35,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  _buttonExit() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context, null);
            },
            child: Image.asset(
              "images/icon_close.png",
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
              color: KPrimary_L1,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonAccept() {
    return Center(
      child: InkWell(
        onTap: widget.enableRange
            ? (selectedEndDate != null && selectedStartDate != null
                ? () {
                    Navigator.pop(context, {
                      "startDate": selectedStartDate as DateTime,
                      "endDate": selectedEndDate as DateTime,
                    });
                  }
                : () {})
            : (selectedStartDate != null && enableButton
                ? () {
                    Navigator.pop(context, {
                      "startDate": selectedStartDate as DateTime,
                    });
                  }
                : () {}),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _colorButton(),
              width: 1,
            ),
            color: _colorButton(),
          ),
          child: Center(
            child: Text(
              widget.buttonName ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: KFontSizeLarge40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorButton() {
    Color color;
    if (widget.enableRange) {
      selectedEndDate != null && selectedStartDate != null
          ? color = KPrimary
          : color = KGrey_L2;
    } else {
      selectedStartDate != null && enableButton
          ? color = KPrimary
          : color = KGrey_L2;
    }
    return color;
  }

  List<AmountSelected> _generateYears() {
    int i = DateTime.now().year;
    for (i; i >= initYear; i--) {
      yearList.add(AmountSelected(amount: i));
    }
    return yearList;
  }

  TableCalendar _buildTableCalendar() => TableCalendar(
        locale: locale,
        focusedDay: tapYear
            ? focusDay ?? selectedStartDate ?? minDate
            : widget.enableRange
                ? selectedStartDate ?? minDate
                : selectedStartDate ?? DateTime.now(),
        selectedDayPredicate: (day) {
          return false;
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (!widget.enableRange) {
              verificateDate(selectedDay);
            }
            _onDaySelected(selectedDay, focusedDay);
          });
        },
        firstDay: widget.enableRange
            ? widget.minDate ?? DateTime.now()
            : DateTime(initYear),
        lastDay: widget.enableRange
            ? widget.maxDate ?? DateTime.now().add(const Duration(days: 365))
            : DateTime.now(),
        calendarFormat: CalendarFormat.month,
        rangeSelectionMode: RangeSelectionMode.enforced,
        rangeStartDay: selectedStartDate,
        rangeEndDay: widget.enableRange ? selectedEndDate : null,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: true,
          defaultTextStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.normal,
            color: KGrey,
          ),
          weekendTextStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            color: KGrey,
            fontWeight: FontWeight.normal,
          ),
          selectedTextStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.normal,
            color: KGrey,
          ),
          selectedDecoration: const BoxDecoration(color: Colors.transparent),
          rangeHighlightColor: KPrimary_L3,
          withinRangeTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: KFontSizeLarge40,
          ),
          holidayTextStyle: const TextStyle().copyWith(color: KGrey),
        ),
        rowHeight: 50,
        daysOfWeekHeight: 30,
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) =>
              DateFormat.E(locale).format(date)[0].toUpperCase(),
          weekendStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.normal,
            color: KGrey,
          ),
          weekdayStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.normal,
            color: KGrey,
          ),
        ),
        headerStyle: HeaderStyle(
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            size: 30,
            color: KPrimary,
          ),
          leftChevronMargin: const EdgeInsets.all(0),
          leftChevronPadding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(
                color: KPrimary,
                width: 1,
              ),
            ),
          ),
          headerMargin: const EdgeInsets.only(bottom: 15),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            size: 30,
            color: KPrimary,
          ),
          headerPadding: const EdgeInsets.only(bottom: 5, left: 0, right: 0),
          rightChevronMargin: const EdgeInsets.all(0),
          rightChevronPadding: const EdgeInsets.all(0),
          titleCentered: true,
          formatButtonVisible: false,
          titleTextFormatter: (date, locale) =>
              "${DateFormat.MMMM(locale).format(date).capitalize()} ${DateFormat.y(locale).format(date)}",
          titleTextStyle: const TextStyle(
            fontSize: KFontSizeLarge40,
            fontWeight: FontWeight.normal,
            color: KPrimary,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) => Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: date.day == DateTime.now().day &&
                        date.month == DateTime.now().month &&
                        date.year == DateTime.now().year
                    ? KGrey_L2
                    : Colors.transparent,
              ),
            ),
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: KFontSizeLarge40,
                color: KGrey,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          todayBuilder: (context, date, _) => Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: KGrey_L2,
              ),
            ),
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: KFontSizeLarge40,
                color: KGrey,
              ),
            ),
          ),
          disabledBuilder: (context, date, _) => Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: KFontSizeLarge40,
                color: KGrey_L2,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          selectedBuilder: (context, date, _) => Container(
            margin: const EdgeInsets.all(5.0),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: KPrimary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: KFontSizeLarge40,
                color: KWhite,
              ),
            ),
          ),
          rangeEndBuilder: (context, date, _) => Container(
            margin: const EdgeInsets.all(5.0),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: KPrimary_L1,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: KFontSizeLarge40,
                color: Colors.white,
                backgroundColor: KPrimary_L1,
              ),
            ),
          ),
          rangeStartBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: KPrimary_L1,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: KFontSizeLarge40,
                  color: KWhite,
                ),
              ),
            );
          },
        ),
        onHeaderTapped: (DateTime datetime) async {
          if (widget.enableRange == false && widget.enableYearSelection) {
            var result = await _showAmountSelection(
              context,
              amount: yearList,
              initAmount: datetime.year,
              title: widget.titleYearSelect,
              subTitle: widget.subTitleYearSelect,
            );
            if (result != null) {
              focusDay = DateTime(
                int.parse(result),
                datetime.month < DateTime.now().month
                    ? datetime.month
                    : DateTime.now().month,
                1,
              );
              selectedStartDate = null;
              tapYear = true;
              enableButton = false;
              changedDate = false;
              setState(() {});
            }
          }
        },
      );

  verificateDate(DateTime selectedDay) {
    tap = true;
    if (widget.selectDate == null) {
      changedDate = true;
      enableButton = true;
      return;
    }
    if (widget.selectDate!.year != selectedDay.year ||
        widget.selectDate!.month != selectedDay.month ||
        widget.selectDate!.day != selectedDay.day) {
      changedDate = true;
      enableButton = true;
      return;
    }
    if (changedDate) {
      enableButton = true;
      return;
    }
    enableButton = false;
    return;
  }
}

//Amount selector
class _AmountSelectionPopUpItem {
  _AmountSelectionPopUpItem({required this.text, required this.isEnabled});

  String text;
  bool isEnabled;
  bool isSelected = false;
}

class AmountSelected {
  int amount;
  bool isSelected;

  AmountSelected({required this.amount}) : isSelected = false;
}

Future _showAmountSelection(
  BuildContext context, {
  required List<AmountSelected> amount,
  String? subTitle,
  String? title,
  int? initAmount,
  double? width,
  double? height,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return _AmountSelectionPopup(
        context: context,
        amount: amount,
        subTitle: subTitle,
        title: title,
        initAmount: initAmount,
        width: width,
        height: height,
      );
    },
  );
}

class _AmountSelectionPopup extends StatefulWidget {
  const _AmountSelectionPopup(
      {Key? key,
      required this.context,
      required this.amount,
      this.width,
      this.title,
      this.subTitle,
      this.height,
      this.initAmount})
      : super(key: key);

  final List<AmountSelected> amount;
  final BuildContext context;
  final double? width;
  final double? height;
  final String? subTitle;
  final String? title;
  final int? initAmount;

  @override
  State<_AmountSelectionPopup> createState() => _AmountSelectionPopupState();
}

class _AmountSelectionPopupState extends State<_AmountSelectionPopup> {
  int selectedAmountIndex = 0;
  List<_AmountSelectionPopUpItem>? list;
  late List<AmountSelected> amount;

  @override
  void initState() {
    super.initState();
    amount = widget.amount;
    if (widget.initAmount != null) {
      selectedAmountIndex =
          amount.indexWhere((element) => element.amount == widget.initAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _dialog();
  }

  _dialog() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _background(),
          _body(),
        ],
      ),
    );
  }

  _background() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        "images/background_popup.png",
        fit: BoxFit.fill,
        height: height,
        width: width,
      ),
    );
  }

  _body() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Container(
          width: widget.width ?? MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: _content(),
        ),
      ),
    );
  }

  _content() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: 20),
          _subTitle(),
          const SizedBox(height: 5),
          const Divider(
            color: KPrimary,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          _list(),
          //_messageText(),
          const SizedBox(height: 15),
          _buttonAccept()
        ],
      ),
    );
  }

  _header() {
    return Stack(
      children: [_title(), _buttonExit()],
    );
  }

  _title() {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          widget.title ?? "",
          softWrap: true,
          style: const TextStyle(
            color: KGrey,
            fontWeight: FontWeight.w400,
            fontSize: KFontSizeLarge40,
          ),
        ),
      ),
    );
  }

  _buttonExit() {
    return Visibility(
      visible: true,
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context, null);
          },
          child: Image.asset(
            "images/icon_close.png",
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
            color: KPrimary_L1,
            height: 20,
          ),
        ),
      ),
    );
  }

  _subTitle() {
    return Center(
      child: Text(
        widget.subTitle ?? "",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: KFontSizeXLarge45,
          fontWeight: FontWeight.w200,
          color: KPrimary,
        ),
      ),
    );
  }

  _list() {
    return SizedBox(
      height: widget.height ?? 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Center(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: selectedAmountIndex,
                ),
                itemExtent: 50,
                onSelectedItemChanged: (value) => {
                  setState(() {
                    selectedAmountIndex = value;
                  })
                },
                children: List.generate(
                  amount.length,
                  (index) => Center(
                    child: selectedAmountIndex == index
                        ? (Text(
                            amount[index].amount.toString(),
                            style: const TextStyle(
                              color: KPrimary,
                              fontSize: KFontSizeXXLarge50,
                            ),
                          ))
                        : (Text(
                            amount[index].amount.toString(),
                            style: const TextStyle(
                              color: KGrey,
                              fontSize: KFontSizeLarge40,
                            ),
                          )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonAccept() {
    return RoundedButton(
      text: "Guardar",
      onPressed: () {
        Navigator.pop(context, amount[selectedAmountIndex].amount.toString());
      },
      width: MediaQuery.of(context).size.width,
      fontWeight: FontWeight.w800,
      fontSize: KFontSizeLarge40,
    );
  }
}
