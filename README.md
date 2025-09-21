# 🏠 Ghar Dalali - Real Estate Management System

A comprehensive web-based real estate management platform built with Java Servlet technology, designed to facilitate property listings, user management, and application tracking for real estate transactions.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Database Schema](#database-schema)
- [Installation & Setup](#installation--setup)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Security Features](#security-features)
- [Team Contributions](#team-contributions)
- [Future Enhancements](#future-enhancements)

## 🎯 Overview

Ghar Dalali is a full-stack web application that serves as a comprehensive real estate management platform. It enables users to browse properties, apply for rentals/purchases, manage user profiles, and provides administrative capabilities for property and user management.

### Key Objectives
- **Property Management**: Complete CRUD operations for property listings
- **User Management**: Role-based authentication and user profile management
- **Application Tracking**: Streamlined property application process
- **Review System**: Property rating and review functionality
- **Admin Dashboard**: Comprehensive administrative interface

## ✨ Features

### 🔐 Authentication & Authorization
- **User Registration & Login**: Secure user authentication with password hashing
- **Role-Based Access Control**: Separate interfaces for buyers and administrators
- **Remember Me**: Persistent login sessions using cookies
- **Password Reset**: Email-based password recovery system
- **Session Management**: Secure session handling with automatic timeout

### 🏘️ Property Management
- **Property Listings**: Browse properties with advanced filtering
- **Property Details**: Comprehensive property information with image galleries
- **Property Types**: Support for Apartments, Houses, Villas, Commercial spaces, and Land
- **Image Management**: Multiple image uploads with primary image designation
- **Search & Filter**: Location-based and type-based property filtering
- **Status Tracking**: FOR_SALE, FOR_RENT, SOLD, RENTED status management

### 📋 Application Management
- **Property Applications**: Users can apply for properties of interest
- **Application Tracking**: Real-time application status updates
- **Admin Approval**: Administrative review and approval workflow
- **Application History**: Complete application tracking for users

### ⭐ Review System
- **Property Reviews**: 5-star rating system with written reviews
- **Review Moderation**: Admin approval for review publication
- **User Reviews**: Track user review history and contributions

### 👥 User Management
- **Profile Management**: Complete user profile with bio and contact information
- **User Dashboard**: Personalized user interface with activity tracking
- **Admin User Management**: Administrative user creation, editing, and deletion
- **Activity Logging**: Comprehensive user activity tracking

### 📊 Admin Dashboard
- **Dashboard Analytics**: Property statistics and user metrics
- **User Management**: Complete user administration
- **Property Administration**: Property CRUD operations
- **Application Management**: Review and manage property applications
- **Review Moderation**: Approve/reject property reviews

### 📞 Contact System
- **Contact Form**: User inquiry submission system
- **Message Management**: Admin interface for contact message handling
- **Email Integration**: Automated email notifications

## 🛠️ Technology Stack

### Backend Technologies
- **Java 17+**: Core programming language
- **Jakarta Servlet API 6.0**: Web application framework
- **MySQL 8.0**: Relational database management system
- **JDBC**: Database connectivity and operations
- **JSTL 3.0**: JavaServer Pages Standard Tag Library

### Frontend Technologies
- **HTML5**: Semantic markup structure
- **CSS3**: Modern styling with responsive design
- **JavaScript (ES6+)**: Client-side interactivity
- **JSP (JavaServer Pages)**: Dynamic web page generation
- **Bootstrap**: Responsive UI framework

### Development Tools
- **Apache Tomcat**: Servlet container and web server
- **Eclipse IDE**: Integrated development environment
- **Maven**: Project management and build automation
- **Git**: Version control system

### Security Features
- **SHA-256 Password Hashing**: Secure password storage
- **Session Management**: Secure session handling
- **Authentication Filter**: Request-level security
- **SQL Injection Prevention**: Prepared statements
- **XSS Protection**: Input validation and sanitization

## 🏗️ Architecture

### MVC Pattern Implementation
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   View Layer    │    │ Controller Layer│    │   Model Layer   │
│                 │    │                 │    │                 │
│ • JSP Pages     │◄──►│ • Servlets      │◄──►│ • Java Models   │
│ • CSS/JS        │    │ • Filters       │    │ • Services      │
│ • Static Assets │    │ • Utilities     │    │ • Database      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Package Structure
```
com.GharDalali/
├── config/          # Database configuration
├── controller/      # Servlet controllers
├── filter/          # Authentication filters
├── model/           # Data models
├── service/         # Business logic services
├── util/            # Utility classes
└── view/            # View servlets
```

### Request Flow
1. **Client Request** → Servlet Container
2. **Authentication Filter** → Security validation
3. **Controller Servlet** → Business logic processing
4. **Service Layer** → Data operations
5. **Model Layer** → Database interactions
6. **View Layer** → Response rendering

## 🗄️ Database Schema

### Core Tables

#### Users Table
```sql
CREATE TABLE users (
    userid INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    contactNumber VARCHAR(15),
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'buyer',
    address VARCHAR(255),
    profilePicture VARCHAR(255),
    bio TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active'
);
```

#### Properties Table
```sql
CREATE TABLE properties (
    property_id INT PRIMARY KEY AUTO_INCREMENT,
    property_name VARCHAR(100) NOT NULL,
    property_type ENUM('Apartment','House','Villa','Commercial','Land'),
    description TEXT,
    location VARCHAR(255) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    bedrooms INT,
    bathrooms INT,
    size DECIMAL(10,2),
    size_unit VARCHAR(10) DEFAULT 'sq.ft',
    status ENUM('FOR_SALE','FOR_RENT','SOLD','RENTED'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Property Applications Table
```sql
CREATE TABLE property_applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    userid INT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    message TEXT NOT NULL,
    status ENUM('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Reviews Table
```sql
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'PENDING',
    UNIQUE KEY unique_user_property_review (user_id, property_id)
);
```

### Database Relationships
- **Users** ↔ **Property Applications** (One-to-Many)
- **Properties** ↔ **Property Applications** (One-to-Many)
- **Properties** ↔ **Property Images** (One-to-Many)
- **Users** ↔ **Reviews** (One-to-Many)
- **Properties** ↔ **Reviews** (One-to-Many)

## 🚀 Installation & Setup

### Prerequisites
- **Java Development Kit (JDK) 17+**
- **Apache Tomcat 10.0+**
- **MySQL 8.0+**
- **Eclipse IDE** (recommended)
- **Maven** (for dependency management)

### Step 1: Database Setup
```bash
# Create MySQL database
mysql -u root -p
CREATE DATABASE ghar_dalali;
USE ghar_dalali;

# Import database schema
mysql -u root -p ghar_dalali < ghar_dalali.sql
```

### Step 2: Project Configuration
1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd Ghar_Dalali
   ```

2. **Configure Database Connection**:
   - Update `src/main/java/com/GharDalali/config/DbConfig.java`
   - Modify database URL, username, and password as needed

3. **Configure Tomcat**:
   - Set up Tomcat server in Eclipse
   - Deploy the project to Tomcat
   - Configure server.xml if needed

### Step 3: Build and Deploy
```bash
# Clean and compile
mvn clean compile

# Package the application
mvn package

# Deploy to Tomcat
cp target/Ghar_Dalali.war $TOMCAT_HOME/webapps/
```

### Step 4: Access the Application
- **URL**: `http://localhost:8080/Ghar_Dalali`
- **Default Admin**: `durga@superadmin.com` / `password`
- **Test User**: `user@example.com` / `password`

## 📁 Project Structure

```
Ghar_Dalali/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/GharDalali/
│       │       ├── config/          # Database configuration
│       │       ├── controller/       # Servlet controllers (22 files)
│       │       ├── filter/          # Authentication filters
│       │       ├── model/          # Data models (8 files)
│       │       ├── service/        # Business logic (8 files)
│       │       ├── util/           # Utility classes (5 files)
│       │       └── view/          # View servlets
│       └── webapp/
│           ├── css/                # Stylesheets (18 files)
│           ├── js/                 # JavaScript files (8 files)
│           ├── images/             # Static images
│           ├── WEB-INF/
│           │   ├── lib/           # JAR dependencies
│           │   ├── pages/         # JSP pages (22 files)
│           │   └── web.xml        # Web application configuration
│           └── META-INF/
├── build/                         # Compiled classes
├── ghar_dalali.sql               # Database schema
└── README.md                     # Project documentation
```

## 🔌 API Endpoints

### Authentication Endpoints
- `POST /login` - User login
- `POST /register` - User registration
- `POST /forgotPassword` - Password reset request
- `POST /resetPassword` - Password reset confirmation
- `GET /logout` - User logout

### Property Endpoints
- `GET /properties` - List all properties
- `GET /property-detail` - Property details
- `POST /addProperty` - Add new property (Admin)
- `POST /updateProperty` - Update property (Admin)
- `POST /deleteProperty` - Delete property (Admin)

### Application Endpoints
- `POST /applyProperty` - Submit property application
- `GET /applicationTracking` - Track applications
- `POST /updateApplicationStatus` - Update status (Admin)

### User Management Endpoints
- `GET /profile` - User profile
- `POST /updateProfile` - Update user profile
- `POST /addUser` - Add user (Admin)
- `POST /editUser` - Edit user (Admin)
- `POST /deleteUser` - Delete user (Admin)

### Review Endpoints
- `POST /submitReview` - Submit property review
- `POST /deleteReview` - Delete review (Admin)

### Admin Endpoints
- `GET /adminDashboard` - Admin dashboard
- `GET /adminProperties` - Property management
- `GET /adminUsers` - User management
- `POST /contact` - Contact form submission

## 🔒 Security Features

### Authentication & Authorization
- **Password Hashing**: SHA-256 algorithm for secure password storage
- **Session Management**: Secure session handling with automatic timeout
- **Role-Based Access**: Separate access levels for buyers and administrators
- **Remember Me**: Secure cookie-based persistent login

### Input Validation & Sanitization
- **SQL Injection Prevention**: Prepared statements for all database queries
- **XSS Protection**: Input validation and output encoding
- **File Upload Security**: Image type validation and size limits
- **Form Validation**: Client-side and server-side validation

### Security Headers & Configuration
- **Authentication Filter**: Request-level security validation
- **Secure Cookies**: HttpOnly and Secure cookie flags
- **CSRF Protection**: Token-based request validation
- **Error Handling**: Secure error messages without sensitive information

## 👥 Team Contributions

| **Team Member** | **Contributions** |
|------------------|-------------------|
| **Bardan Gurung** | 🖥️ Front End: Login, Registration Pages<br/>🛠️ Utilities: Cookie, Session<br/>🔒 Auth Filtering & Management<br/>👤 User Profile Update<br/>🎛️ Role-Based Authentication<br/>💾 Back End: Property CRUD<br/>💻 JavaScript<br/>✅ Testing |
| **Manish Jung Adhikari** | 🔄 Database Normalization (1NF, 2NF, 3NF)<br/>📐 Web Page Wireframing<br/>🗺️ Entity Relation Diagram (ERD)<br/>🖥️ Front End: 404 Error Page, Reset Password<br/>🖼️ Image Sourcing<br/>🛠️ Back End Utils: Image, Password, Validation, User CRUD<br/>🔐 Password Hashing<br/>✅ Testing |
| **Soumyata Shakya** | 🖥️ Front End: Terms Page, Policy Page, Reset Password, About Us<br/>📝 Report Writing<br/>💾 Back End: DB-Config<br/>💻 JavaScript<br/>📐 Wireframing<br/>✅ Testing |
| **Avhiyan Khanal (Leader)** | 🖥️ Front End: Footer, Add User.jsp<br/>💾 Database Creation (Create, Insert)<br/>🗺️ Entity Relation Diagram (ERD)<br/>🖼️ Image Sourcing<br/>📝 Report Writing<br/>🛠️ Back End: Password Hashing, User CRUD, Image Util, Password Util, Validation Util<br/>✅ Testing |
| **Paurakh Pyakurel** | 🖥️ Front End: Admin-Dashboard, Contact, Edit-Property, Edit-User, Home, Properties, Property-detail, Admin Nav-Bar, User Profile, Blog Page<br/>⭐ Property Review Management<br/>📋 Application Management<br/>🖼️ Image Sourcing<br/>🔐 Password Hashing (Back End)<br/>👥 User CRUD<br/>📐 Wireframing<br/>✅ Testing |

✨ _Every team member contributed to both front-end and back-end development, testing, and documentation!_

## 🔮 Future Enhancements

### Planned Features
- **Mobile Application**: Native mobile app development
- **Advanced Search**: AI-powered property recommendations
- **Payment Integration**: Online payment processing
- **Email Notifications**: Automated email alerts
- **Map Integration**: Interactive property location maps
- **Multi-language Support**: Internationalization
- **API Development**: RESTful API for third-party integrations
- **Advanced Analytics**: Business intelligence dashboard
- **Social Features**: User reviews and social sharing
- **Property Comparison**: Side-by-side property comparison

### Technical Improvements
- **Microservices Architecture**: Service-oriented architecture
- **Cloud Deployment**: AWS/Azure cloud hosting
- **Containerization**: Docker and Kubernetes deployment
- **CI/CD Pipeline**: Automated testing and deployment
- **Performance Optimization**: Caching and database optimization
- **Security Enhancements**: OAuth 2.0 and JWT implementation

## 📞 Support & Contact

For technical support, feature requests, or bug reports, please contact the development team or create an issue in the project repository.

---

**Developed with ❤️ by the Ghar Dalali Development Team**

*Last Updated: January 2025*
