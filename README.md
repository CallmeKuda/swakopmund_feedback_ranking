# Swakopmund Tourist Feedback Analysis

This project provides a semi-automated solution using **Robot Framework**, **Selenium**, and **Python** to scrape, analyze, and visualize user feedback from the [Namibia Tours & Safaris traveller reviews page](https://www.namibia-tours-safaris.com/about-us/traveller-reviews).

---

## 📌 Overview

- Scrapes traveler reviews from the NTS website.
- Stores the reviews in a JSON file.
- Generates a bar graph showing frequency of reviews per reviewer.
- Outputs all artifacts (logs, screenshots, reports) in the `output/` folder.

---

🚀 How to Run
Option 1: Manual

python -m robot --outputdir output tests/feedback_analysis.robot

Option 2: Use Shortcut Script

    Windows:

run_tests.bat

Linux/macOS:

    ./run_tests.sh

📊 Outputs & Logs

