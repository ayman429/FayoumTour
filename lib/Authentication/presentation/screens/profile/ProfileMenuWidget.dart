
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  }) : super(key: key);

  
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).colorScheme.primary;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: endIcon ? iconColor : Colors.red),
      ),
      title: Text(title,
          style: TextStyle(
            fontFamily: "aBeeZee",
            fontWeight: FontWeight.bold, color: endIcon ? Theme.of(context).colorScheme.onPrimary : Colors.red)
          ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child:
                  const Icon(Icons.arrow_right, size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
