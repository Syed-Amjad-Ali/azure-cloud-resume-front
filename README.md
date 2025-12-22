## 🚀 Project Background & Motivation

This project started as a hands-on way to deeply understand Azure’s core building blocks by **deploying and operating a real, production-style system**, rather than stopping at theory or isolated demos.

While researching practical Azure projects, I came across the **Cloud Resume Challenge (Azure edition)** — a well-known community challenge that outlines what a cloud-native resume website should look like in production: static hosting, serverless backends, databases, infrastructure as code, and CI/CD.

Instead of treating it as a checklist to rush through, I used the challenge as a **design reference** and spent significant time researching *why* each component exists, how they interact, and where Azure’s managed services fit into a real deployment workflow.

I was also inspired by cloud practitioners who focus on learning-by-building, including content by **Gwyneth Peña-Siguenza (GPSlearnsAI)**, whose Azure-focused projects reinforced the importance of understanding platform fundamentals through real systems rather than toy examples.

---

## 🧱 What This Project Implements

This repository contains the **frontend** for my personal website, deployed and operated entirely on Azure using modern cloud-native practices.

### ✅ Core Architecture

- **Custom domain**  
  `https://syedamjadali.no`

- **Azure Storage Static Website**  
  Frontend assets are hosted from Azure Blob Storage (`$web` container).

- **HTTPS & Global Delivery**  
  Azure CDN (Front Door / CDN endpoint) is used to enable HTTPS and global caching.

- **Visitor Counter (Serverless)**  
  - JavaScript frontend integration  
  - Azure Function (HTTP-triggered)  
  - Cosmos DB used to persist visit counts  
  *(Backend CI/CD will be added separately)*

- **Cosmos DB (Serverless)**  
  Stores and updates page visit counts with minimal cost and overhead.

---

## 🔄 CI/CD: Automated Frontend Deployment (OIDC-based)

A key goal of this project was implementing **secure, production-style CI/CD** without hardcoded secrets or manual deployments.

### On every push to `main`:

1. GitHub Actions authenticates to Azure using **OpenID Connect (OIDC)**  
   - No client secrets  
   - No stored credentials  
   - No JSON keys committed to the repository

2. Static site files are automatically uploaded to Azure Blob Storage

3. Azure CDN cache is purged to ensure global updates propagate correctly

This ensures that **any frontend change is automatically deployed** end-to-end, from GitHub to a globally accessible HTTPS website.

---

## 🧠 Why This Project Matters

This project reflects how I approach cloud and data platforms:

- Emphasis on **understanding system boundaries**, not just writing code  
- Preference for **managed Azure services** where appropriate  
- Security-first mindset (OIDC, RBAC, secretless authentication)  
- Focus on **repeatable, automated deployments** over manual portal configuration  

This is not a demo site — it is a small but complete cloud system that I actively operate and improve.

---

## 🔗 Links

- **Live website:** https://syedamjadali.no  
- **Frontend repository:** this repo  
- **Backend (Azure Functions & Cosmos DB):** *(to be linked once CI/CD is added)*  
