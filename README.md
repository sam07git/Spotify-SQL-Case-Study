# 🎧 Spotify User Behavior Analysis (SQL Case Study)

## 📌 Project Overview

This project analyzes user behavior data from a Spotify-like platform using SQL.
The objective is to uncover patterns in user engagement, subscription preferences, and listening habits to derive actionable insights.

---

## 📊 Dataset Details

* 📁 Records: 50,000 users
* 📌 Columns: 18 features
* 🧾 Includes:

  * User demographics (age, country)
  * Subscription type
  * Listening behavior (hours, skips)
  * Engagement metrics (playlists, ratings, ad interaction)

---

## 🎯 Business Objectives

* Identify highly engaged user segments
* Compare Free vs Premium user behavior
* Analyze factors affecting user inactivity
* Understand demographic-based usage patterns

---

## 🔍 Key Insights

* 📈 **Free users dominate the platform** and show slightly higher listening hours
* ⚖️ **Engagement across age groups is consistent**, with 36–50 being the largest segment
* 🔄 **Skipping behavior does not significantly impact inactivity**, indicating other hidden factors
* 🎧 **Genre preferences vary across users**, but high listening does not always mean low skipping
* 💡 **No strong observable factors explain inactivity**, suggesting need for deeper behavioral or external data

---

## 🧠 Key Analysis Performed

* 📊 Aggregation & segmentation using `GROUP BY`
* 🔄 Conditional logic using `CASE WHEN`
* 📈 Behavior comparison using `AVG`, `COUNT`
* 🏆 Ranking using `RANK()` and `PARTITION BY`
* 🧮 Derived metric creation (Engagement Score)

---

## 🛠️ Tools & Technologies

* 💻 SQL (MySQL Workbench)
* 🗄️ Relational Database
* 📊 Analytical Thinking

---

## 📁 Project Structure

```
Spotify-SQL-Case-Study/
│
├── queries.sql     # All SQL queries used in analysis
├── README.md       # Project documentation
```

---

## 🚀 Future Improvements

* 📊 Build interactive dashboard using Power BI / Tableau
* 🔍 Perform deeper user segmentation
* 📡 Use real-world dataset for stronger insights
* 🤖 Apply machine learning for churn prediction

---

## 📢 Conclusion

This project demonstrates how SQL can be used to extract meaningful insights from user behavior data.
It highlights the importance of data-driven decision-making and shows practical application of analytical techniques in a real-world scenario.
