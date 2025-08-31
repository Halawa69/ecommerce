# 🛒 Flutter E-Commerce App

A modern **E-Commerce mobile application** built with **Flutter** following **Clean Architecture principles**.  
This project demonstrates best practices for building scalable, maintainable, and production-ready apps.

---

## ✨ Features
- ✅ **User Authentication** (Login & Signup)  
- ✅ **Add to Cart** functionality  
- ✅ **Search Products**  
- ✅ **Filter by Categories**  
- ✅ Clean Architecture with layered structure  
- ✅ State management using **Provider**  
- ✅ Local storage with **SharedPreferences** & **Sqflite**
- 
---

## 📂 Project Structure
```bash
lib/
│
├── core/                # Reusable components & utilities
├── features/            # Feature-based modules
│   ├── auth/            # Authentication (Login & Signup)
│   ├── cart/            # Cart management (Add to Cart, etc.)
│   ├── home/            # Product listing, details, search & filters
│   └── ...
│
└── main.dart            # Entry point
