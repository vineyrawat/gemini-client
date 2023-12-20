import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_client/providers/app_settings_provider.dart';
import 'package:toastification/toastification.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var inputController = TextEditingController();
    var appSettings = ref.watch(appSettingsProvider);

    inputController.text = appSettings.geminiApiKey;

    log("NEW API KEY: ${inputController.text}");

    handleSave() {
      ref.read(appSettingsProvider.notifier).setApiKey(inputController.text);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Saved")));
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        title: 'Settings Saved',
        description: 'New settings has been saved',
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
        boxShadow: lowModeShadow,
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: handleSave,
          label: const Text("Save Details"),
          icon: const Icon(CupertinoIcons.checkmark_alt_circle)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: inputController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: const Text("API Key"),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: inputController.text));
                    toastification.show(
                      context: context,
                      type: ToastificationType.success,
                      style: ToastificationStyle.flat,
                      title: 'Copied',
                      description: 'API key copied to clipboard',
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 4),
                      boxShadow: lowModeShadow,
                    );
                  },
                ),
                hintText: 'Add your gemini api key here',
                contentPadding: const EdgeInsets.all(15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                CupertinoIcons.doc_text_viewfinder,
                size: 30,
              ),
              title: const Text("Enable Document Upload"),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: false,
                onChanged: (value) {
                  toastification.show(
                      context: context,
                      type: ToastificationType.warning,
                      style: ToastificationStyle.flat,
                      title: 'Coming Soon',
                      description: 'Coming Soon',
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 4),
                      boxShadow: lowModeShadow,
                      showProgressBar: false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
