# Perfect Profile — iOS Application

**A physician-developed application for sharing treatment plans and medication information with patients.**

Swift · UIKit · Storyboards · URLSession · Apple Push Notification service

[Backend and project overview](https://github.com/maheration/perfect-profile)

## The clinical problem

Patients receiving ongoing care need a clear way to access their treatment plan, medication information and laboratory-monitoring instructions between appointments. Perfect Profile was designed for a glomerulonephritis (GN) clinic to make clinician-entered care information available through a patient-facing mobile application.

## My contribution

I designed and developed both the native Swift iOS application and the Node.js/Express backend with MongoDB, including patient and clinician interfaces and Apple push-notification integration.

## Features implemented in the source

- **Patient interface:** view clinician-entered diagnosis, treatment plan, laboratory-monitoring instructions and medications.
- **Clinician interface:** select patients, create and edit treatment plans, and add, update or remove medications.
- **Account workflows:** registration, login and separate patient/clinician navigation.
- **Notifications:** register device tokens and request a patient notification following plan or medication changes.
- **API integration:** connect the mobile screens to the companion backend using JSON requests.

Laboratory information is entered as text instructions; this is not an integration with a laboratory-results system. Push notifications alert patients to an update; the source does not establish a complete automatic content-refresh workflow.

## Code guide

| Area | Main files |
| --- | --- |
| Patient experience | `PatientMainVC.swift`, `PatientMedsVC.swift`, `PatientMedDetailVC.swift` |
| Clinician experience | `AdminMainVC.swift`, `AdminPatientViewVC.swift`, plan and medication controllers |
| API requests | `DataService.swift` |
| Registration and login | `AuthService.swift`, `RegisterVC.swift`, `LoginVC.swift` |
| Push registration and badges | `AppDelegate.swift` |
| Models | `Plan.swift`, `Medication.swift`, `Patient.swift` |
| Screen layouts | `Profile/Base.lproj/Main.storyboard` |

## Project history

Developed in **2017–2018**. This repository preserves the original work as a historical portfolio project; it is not actively maintained. The source demonstrates the features described above, but current build compatibility and notification delivery have not been revalidated.

I provided the code to the University of Alberta for possible implementation. I cannot confirm subsequent implementation or adoption, and no measured clinical or operational outcomes are claimed.

## Technical context

The original project specifies Swift 3.0 and iOS 10.1. Open `Profile.xcodeproj` to inspect the project on macOS. Historical network and Apple signing settings are not a supported live service. This legacy implementation has known security and reliability limitations and should not be used with real patient data or deployed as-is.
