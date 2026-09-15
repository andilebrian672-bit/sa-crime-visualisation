# 🇿🇦 Geographic Analysis of Contact Crimes in South Africa (2011–2023)
> A three-part data visualisation project investigating the spatial distribution, statistical relationship, and long-term per-capita rates of contact crime across South Africa's nine provinces, using official SAPS crime statistics and Stats SA population estimates.

**Author:** Andile Brian Sithole
**Data Sources:**
- [SAPS Crime Stats 2011–2023 (Kaggle)](https://www.kaggle.com/datasets/harutyunagabayyan/crime-stats-of-south-africa-2011-2023) — curated by Harutyun Gabayyan
- [Stats SA Mid-year Population Estimates 2021 (P0302)](http://www.statssa.gov.za/publications/P0302/P03022021.pdf)

---

##  Project Overview

Crime in South Africa is not evenly distributed. This project uses three complementary visualisations to examine contact crimes — a category that includes murder, attempted murder, sexual offences, assault, and robbery — from three different analytical angles:

1. **Where** are crimes concentrated? (geography)
2. **What moves together?** (correlation between crime types)
3. **Who is most at risk?** (per-capita normalisation)

Each visualisation builds on the last, moving from raw counts → relationships → rates.

---

##  Objectives

| Part | Type | Objective |
|------|------|-----------|
| 1 | **Univariate** | Map the geographic distribution of reported contact crimes by province for 2022/2023 using a choropleth coloured by total incident counts. |
| 2 | **Bivariate** | Investigate the relationship between total Contact Crimes and Property-Related Crimes across provinces (2011/2012 – 2020/2021) using a scatter plot with provincial geometry points. |
| 3 | **Spatial (Rate)** | Visualise the average annual contact crime rate per 100,000 people per province over 2011–2021, using SAPS data normalised by Stats SA mid-year population estimates. |

---

##  Key Findings

**Part 1 — Absolute Counts (2022/2023)**
- **Gauteng and KwaZulu-Natal** report the highest absolute volumes of contact crime, indicated by the darkest shading.
- **Northern Cape and Free State** report the lowest volumes.
- The burden of crime is **not evenly distributed** — a pattern shaped by population concentration.
- *Limitation:* absolute counts do not account for population size, so they cannot alone indicate prevalence.

**Part 2 — Correlation (2011–2021)**
- There is a **strong positive correlation** between contact crimes and property-related crimes.
- Provinces cluster along a diagonal trend line: high-violence provinces also experience high property crime.
- **Gauteng and KwaZulu-Natal** are clear outliers in the top-right quadrant.
- **Northern Cape** is the standout low-volume outlier (bottom-left).
- This suggests **shared underlying drivers** — likely population density, urbanisation, and economic activity.

**Part 3 — Per-Capita Rates (2011–2021)**
- Once normalised per 100,000 people, the picture **shifts** — **Eastern Cape and Western Cape** show the **highest average annual contact crime rates** over the decade.
- **Limpopo, Mpumalanga, and Free State** show the lowest rates.
- This reveals **deep-seated, structural spatial inequality** in public safety that persists beyond yearly fluctuations.

---

##  Why This Matters

Comparing absolute counts (Part 1) with per-capita rates (Part 3) shows why **methodology matters**:
- A province can top the raw count *and* not be the highest-risk per person.
- Policy responses (policing, resourcing, social intervention) should be based on **rate**, not raw volume.

The correlation in Part 2 supports the idea that crime is **systemic** — not isolated to one category.
