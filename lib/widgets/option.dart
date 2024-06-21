import 'package:flutter/material.dart';

List a = ["የታቀደ", "የተፈፅመ"];

class OccurenceOption extends StatelessWidget {
  final String label;
  final bool isOccured;
  final void Function(bool) setOccurence;
  final bool value;
  const OccurenceOption(
      {super.key,
      required this.label,
      required this.isOccured,
      required this.setOccurence,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Material(
        child: InkWell(
          onTap: () {
            setOccurence(value);
          },
          splashColor: value
              ? Theme.of(context).colorScheme.secondary.withOpacity(0.18)
              : Theme.of(context).colorScheme.primary.withOpacity(0.18),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
                color: isOccured == value
                    ? value
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary
                    : null,
                border: Border.all(
                  width: 1,
                  color: value
                      ? Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.17)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.17),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isOccured == value
                        ? Colors.white
                        : value
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                  ),
                ),
                Icon(
                  value ? Icons.warning_outlined : Icons.alarm_outlined,
                  size: 28,
                  color: isOccured == value
                      ? Colors.white
                      : value
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
