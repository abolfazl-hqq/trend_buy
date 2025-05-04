import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool value = false;

  void onChanged(bool newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            'Profile',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 18, color: Colors.white),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                        ),
                        title: Text(
                          'Abolfazl Haghighi',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          'haghighikia32@gmail.com',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Account Settings',
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: const Icon(Icons.security_rounded),
                        title: Text(
                          'Password & Security',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(
                          'Notification Settings',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout_rounded),
                        title: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Preferences',
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                      ListTile(
                        leading: const Icon(Icons.language_rounded),
                        title: Text(
                          'Language',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: const Icon(Icons.dark_mode_rounded),
                        title: Text(
                          'Dark mode',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: Switch.adaptive(
                          onChanged: onChanged,
                          value: value,
                          activeTrackColor:
                              Theme.of(context).colorScheme.secondary,
                          activeColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
