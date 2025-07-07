# 🚆 Score Card Form - Flutter App

A Flutter-based application used for train coach inspection and cleanliness scoring. It allows users to fill out general information, score specific inspection tasks for each coach, validate input, export data as a PDF, and submit the form data to a remote server as JSON.

---

## ✨ Features

- **General Information Collection:**

  - Work Order Number
  - Work Date
  - Contractor and Supervisor Names
  - Designation
  - Train Number
  - Arrival & Departure Times
  - Inspection Date
  - Coach Attendance Tracking

- **Score Table:**

  - 8 Key Inspection Tasks
  - 13 Coaches per train (C1 to C13)
  - Score Options: `0`, `1`, `X`, `-`
  - Uses dropdowns for easy selection

- **Validation:**

  - All fields are validated using `TextFormField` and form keys

- **PDF Export:**

  - Generates a professional PDF containing all entered data
  - Exports differently for Web (downloads file) and Mobile/Desktop (opens print/share dialog)

- **API Submission:**

  - Sends JSON data to a test endpoint (`https://httpbin.org/post`) using HTTP POST

- **UI Customization:**
  - Background image with adjustable transparency
  - Watermark-like design for PDF exports

---

## 🛠️ Tech Stack

- **Flutter** (UI Toolkit)
- **Provider** (State Management)
- **HTTP** (API Requests)
- **PDF / Printing** (PDF Generation & Export)
- **Intl** (Date Formatting)

---

## 🚀 Getting Started

### 📦 Installation

```bash
git clone https://github.com/DevCodi27/ScoreCardForm.git
cd ScoreCardForm
flutter pub get
```

### ▶️ Run App

```bash
flutter run
```

> For web:

```bash
flutter run -d chrome
```

### 📱 Build APK

```bash
flutter build apk
```

---

## 📤 JSON Submission

- **Endpoint:** `https://httpbin.org/post`
- **Method:** POST
- **Headers:** `Content-Type: application/json`
- **Body:** Contains all form fields and score entries

---

## 📄 PDF Export

- Uses `pdf` and `printing` packages
- Supports:
  - Mobile → Print dialog
  - Web → Auto-download
- Filename: `scorecard.pdf`

---

## 🔐 Notes on Production

- Replace the dummy endpoint with a real API
- Use Firebase or your own backend for data persistence
- Add authentication for secure usage

---

## 🤝 Contributing

Feel free to fork the repo and submit a pull request. Bug reports and feature suggestions are welcome via Issues.

---

## 👨‍💻 Author

**Stan Abishek A**  
B.E. CSE @ PSNACET  
Flutter Developer  
GitHub: [DevCodi27](https://github.com/DevCodi27)

---

## 📜 License

MIT License
