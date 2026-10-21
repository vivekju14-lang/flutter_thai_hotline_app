# Assignment 07 — flutter_thai_hotline_app

**Rajesh Kumar Upadhayay — Student ID: 6819110001**

**สายด่วน THAILAND / THAI HOTLINE APP** is a Flutter directory of Thai travel, emergency, banking and utility contact numbers.

## Screens

| File in `lib/views/` | Class | Purpose |
| --- | --- | --- |
| `splash_screen_ui.dart` | `SplashScreenUI` | Supplied app logo, title, loading indicator; opens Home after two seconds |
| `home_ui.dart` | `HomeUI` | Grey app bar, About action and four fixed bottom tabs |
| `travel_ui.dart` | `TravelUI` | Nine travel contacts |
| `emg_ui.dart` | `EmgUI` | Ten emergency/public-assistance contacts |
| `bank_ui.dart` | `BankUI` | Sixteen bank/customer-service entries |
| `pub_ui.dart` | `PubUI` | Nine utility/telecom contacts |
| `about_ui.dart` | `AboutUI` | Supplied SAU logo/illustration and correct student name/ID |

The About page appears in the mockup even though the main assignment file list only enumerates six files, so it is included as a seventh screen. No missing year-of-study, department or faculty information was invented.

## Interactions

- Switch categories using the bottom navigation. Each list retains its scroll position.
- Tap a row for the number, any service note, and a link to the official source.
- Tap a phone icon to confirm the selected number, then open the device phone application using `tel:`. Cancel leaves the phone application closed.
- An unavailable phone/browser application produces a fallback message. The displayed number remains readable/selectable in the detail sheet.
- The app does not place calls automatically, request microphone/location access, send messages, log account details or process payments. Provider call charges may apply.

## Run

Flutter 3.41+ / Dart 3.11+ recommended for the committed dependency lockfile.

```sh
flutter pub get
flutter run -d chrome
```

For mobile, use a configured Android/iOS emulator or physical device and `flutter run`. iOS development requires macOS and Xcode. A calling application is required to handle `tel:` links; desktop browsers and simulators may have no handler. No direct Android CALL_PHONE permission is needed because the app opens the external dialer rather than placing a call.

## Verification

```sh
flutter analyze
flutter test
flutter build web --no-web-resources-cdn
```

Eight tests cover all 44 records and non-empty resource files, splash navigation, all four tabs, cancel/confirm phone behavior, unavailable-dialer feedback, official source URLs, About identity/back navigation, and the last bank/utility rows on a 320 × 568 viewport. Phone/browser actions are replaced by a recording fake during tests, so tests never contact a service. Web build and browser preview are checked separately. Android/iOS native builds have not been verified on this machine.

## Data and sources

The directory is a static educational app, not an official government service. Contacts were checked against publicly available agency/provider pages on **21 October 2026**. Several referenced pages themselves have earlier publication dates; this review date does not mean each agency newly updated its number on that day. The list is not automatically refreshed.

Each record stores its source URL in `lib/data/hotlines.dart` and `assets/contact_sources.json`. Representative primary sources include:

- [Thailand government emergency directory](https://www.thailand.go.th/issue-focus-detail/003_003?hl=en)
- [Thailand government travel contacts](https://www.thailand.go.th/useful-information-detail/009_152?hl=th)
- [Ministry of Transport](https://www.mot.go.th/mot)
- [Department of Disaster Prevention and Mitigation](https://www.disaster.go.th/home)
- [Transport Co. contact information](https://transport.co.th/home/en/tcl-service/2024/11/27/ticket-reservation-seat-reservation/)
- [Bank of Thailand financial-service contacts](https://www.bot.or.th/content/dam/bot/satang-stories/dmh/L1%20%E0%B8%81%E0%B8%A3%E0%B8%A1%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%88%E0%B8%B4%E0%B8%95.pdf)
- [UOB information for former Citi customers](https://www.uob.co.th/personal/transition-faq/product-credit-cards.page)
- [Thai Credit contact](https://investor.thaicreditbank.com/en/corporate-info/general-information)
- [PEA](https://www.pea.co.th/en/contact-us), [EGAT](https://www.egat.co.th/home/contact/), [MWA](https://www.mwa.co.th/en/?lang=en), [PWA](https://www.pwa.co.th/contents/contact-1662)
- [NT Contact Center](https://www.ntplc.co.th/contact-us/online-services), [dtac](https://www.dtac.co.th/en/postpaid/services/dtacnumber.html), [AIS](https://aiscallcenter.ais.co.th/)

The mockup contains some placeholder/older numbers. The bank and utility pages therefore do not repeat the mockup's incorrect copied bank numbers. The supplied legacy Citi logo is retained with a label explaining that retail customers moved to UOB; its call action uses the UOB contact. The supplied TOT logo is labeled **NT (เดิม TOT)** and uses the NT Contact Center. These deliberate data corrections are separate from the visual layout.

## Design and assets

[Figma assignment reference](https://www.figma.com/design/sadTijq8cG1Mi6a8hu87fs/Mobile-App--flutter_thai_hotline_app?node-id=7007-158).

The Figma connector required editor access and could not return editable layers. The visible shared-file mockup and user screenshot supplied the screen structure. Placeholder image slots are filled with the actual resources supplied by the user in `resource-flutter-thai-hotline-app (2)`: category banners, service logos, the app icon, SAU logo and developer illustration. The original image files are bundled without cropping or substituting external pictures. Platform launcher images are resized renditions of the supplied app icon. The illustrated developer image is a resource illustration, not a claim to be the student's photograph.

Kanit is bundled locally from Google Fonts under the SIL Open Font License (`assets/fonts/OFL.txt`). Service logos and SAU artwork remain the property of their respective owners and are used here as supplied coursework identification assets.

## Submission

Submit the repository URL:

https://github.com/vivekju14-lang/flutter_thai_hotline_app

Display text: **Assignment 07 — Rajesh Kumar Upadhayay — 6819110001**
