part of '../modifiable.dart';

extension ModifyActionExtension on Modifier {
  Modifier onTap(VoidCallback onTap) {
    // addModifiable(
    //   SimpleModifiable(
    //     builder: (child) {
    //       return TouchableOpacity(
    //         onTap: onTap,
    //         child: child,
    //       );
    //     },
    //   ),
    // );
    return this;
  }
}
