<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="context-path" content="${pageContext.request.contextPath}">
                <title>Blog - Ghar Dalali</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/normalize.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/glassmorphism.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home-enhanced.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/blog.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar-fix.css">
            </head>

            <body>
                <!-- Navigation Bar -->
                <header class="navbar">
        <div class="container gd-navbar-container">
            <div class="logo gd-logo">
                <a href="${pageContext.request.contextPath}/view?page=home">
                    <h1>Ghar Dalali</h1>
                </a>
            </div>
            <nav class="nav-menu gd-nav-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/view?page=home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=properties">Properties</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=aboutus">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=blog" class="active">Blog</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=contact">Contact</a></li>
                </ul>
            </nav>
            <div class="auth-buttons gd-auth-buttons">
                <div class="app-tracking-container gd-app-tracking-container">
                    <div class="app-tracking-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <polyline points="10 9 9 9 8 9"></polyline>
                        </svg>
                        <span class="notification-badge empty">0</span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
                <a href="${pageContext.request.contextPath}/view?page=userprofile" class="profile-btn"><svg xmlns="http://www.w3.org/2000/svg" width="24"
                        height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                        stroke-linecap="round" stroke-linejoin="round" class="profile-icon">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg></a>
            </div>
            <div class="mobile-menu-toggle gd-mobile-menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>

                <!-- Page Header -->
                <section class="page-header">
                    <div class="container">
                        <h1>Real Estate <span class="highlight">Blog</span></h1>
                        <p>Insights, tips, and news about the real estate market in Nepal</p>
                        <div class="search-container">
                            <form class="search-form">
                                <input type="text" placeholder="Search blog posts...">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </form>
                        </div>
                    </div>
                </section>

                <!-- Blog Section -->
                <section class="blog-section">
                    <div class="container">
                        <div class="blog-container">
                            <!-- Blog Content -->
                            <div class="blog-content">
                                <!-- Featured Post -->
                                <c:if test="${not empty featuredPosts}">
                                    <c:forEach items="${featuredPosts}" var="featuredPost" varStatus="loop">
                                        <div class="featured-post blog-card">
                                            <div class="blog-image">
                                                <a
                                                    href="${pageContext.request.contextPath}/blog-detail?id=${featuredPost.postId}">
                                                    <img src="${pageContext.request.contextPath}/images/properties/${featuredPost.featuredImage}"
                                                        alt="${featuredPost.title}" loading="lazy">
                                                    <span class="blog-category">${featuredPost.category}</span>
                                                </a>
                                            </div>
                                            <div class="blog-details">
                                                <div class="blog-meta">
                                                    <span>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <polyline points="12 6 12 12 16 14"></polyline>
                                                        </svg>
                                                        <fmt:formatDate value="${featuredPost.createdAt}"
                                                            pattern="MMMM d, yyyy" />
                                                    </span>
                                                    <span>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                            <circle cx="9" cy="7" r="4"></circle>
                                                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                                        </svg>
                                                        By ${featuredPost.authorName}
                                                    </span>
                                                </div>
                                                <h3 class="blog-title">
                                                    <a
                                                        href="${pageContext.request.contextPath}/blog-detail?id=${featuredPost.postId}">${featuredPost.title}</a>
                                                </h3>
                                                <p class="blog-excerpt">
                                                    ${featuredPost.excerpt}
                                                </p>
                                                <a href="${pageContext.request.contextPath}/blog-detail?id=${featuredPost.postId}"
                                                    class="btn btn-outline">Read More</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty featuredPosts}">
                                    <!-- Fallback featured post if no featured posts exist -->
                                    <div class="featured-post blog-card">
                                        <div class="blog-image">
                                            <a href="#">
                                                <img src="${pageContext.request.contextPath}/images/properties/property1.jpg"
                                                    alt="Featured Blog Post" loading="lazy">
                                                <span class="blog-category">Featured</span>
                                            </a>
                                        </div>
                                        <div class="blog-details">
                                            <div class="blog-meta">
                                                <span>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <circle cx="12" cy="12" r="10"></circle>
                                                        <polyline points="12 6 12 12 16 14"></polyline>
                                                    </svg>
                                                    June 15, 2025
                                                </span>
                                                <span>
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                        <circle cx="9" cy="7" r="4"></circle>
                                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                                    </svg>
                                                    By Admin
                                                </span>
                                            </div>
                                            <h3 class="blog-title">
                                                <a href="#">No Featured Posts Available</a>
                                            </h3>
                                            <p class="blog-excerpt">
                                                Check back soon for featured blog posts about real estate trends, tips,
                                                and insights.
                                            </p>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Blog Posts Grid -->
                                <div class="blog-posts-grid">
                                    <c:if test="${not empty allPosts}">
                                        <c:forEach items="${allPosts}" var="post" varStatus="loop">
                                            <c:if test="${not post.featured}">
                                                <!-- Blog Card -->
                                                <div class="blog-card">
                                                    <div class="blog-image">
                                                        <a
                                                            href="${pageContext.request.contextPath}/blog-detail?id=${post.postId}">
                                                            <img src="${pageContext.request.contextPath}/images/properties/${post.featuredImage}"
                                                                alt="${post.title}" loading="lazy">
                                                            <span class="blog-category">${post.category}</span>
                                                        </a>
                                                    </div>
                                                    <div class="blog-details">
                                                        <div class="blog-meta">
                                                            <span>
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                                    height="16" viewBox="0 0 24 24" fill="none"
                                                                    stroke="currentColor" stroke-width="2"
                                                                    stroke-linecap="round" stroke-linejoin="round">
                                                                    <circle cx="12" cy="12" r="10"></circle>
                                                                    <polyline points="12 6 12 12 16 14"></polyline>
                                                                </svg>
                                                                <fmt:formatDate value="${post.createdAt}"
                                                                    pattern="MMMM d, yyyy" />
                                                            </span>
                                                            <span>
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                                    height="16" viewBox="0 0 24 24" fill="none"
                                                                    stroke="currentColor" stroke-width="2"
                                                                    stroke-linecap="round" stroke-linejoin="round">
                                                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2">
                                                                    </path>
                                                                    <circle cx="9" cy="7" r="4"></circle>
                                                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                                                </svg>
                                                                By ${post.authorName}
                                                            </span>
                                                        </div>
                                                        <h3 class="blog-title">
                                                            <a
                                                                href="${pageContext.request.contextPath}/blog-detail?id=${post.postId}">${post.title}</a>
                                                        </h3>
                                                        <p class="blog-excerpt">
                                                            ${post.excerpt}
                                                        </p>
                                                        <a href="${pageContext.request.contextPath}/blog-detail?id=${post.postId}"
                                                            class="btn btn-outline">Read More</a>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty allPosts}">
                                        <div class="no-posts-message">
                                            <p>No blog posts available at the moment. Please check back soon for new
                                                content.</p>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Pagination -->
                                <div class="pagination">
                                    <a href="#" class="pagination-item active">1</a>
                                    <a href="#" class="pagination-item">2</a>
                                    <a href="#" class="pagination-item">3</a>
                                    <a href="#" class="pagination-item next">Next</a>
                                </div>
                            </div>

                            <!-- Blog Sidebar -->
                            <div class="blog-sidebar">
                                <!-- Categories Section -->
                                <div class="sidebar-section">
                                    <h3 class="sidebar-title">Categories</h3>
                                    <ul class="categories-list">
                                        <li><a href="#">Market Trends <span>(12)</span></a></li>
                                        <li><a href="#">Investment Tips <span>(8)</span></a></li>
                                        <li><a href="#">Home Buying Guide <span>(15)</span></a></li>
                                        <li><a href="#">Property Management <span>(6)</span></a></li>
                                        <li><a href="#">Legal Advice <span>(4)</span></a></li>
                                        <li><a href="#">Interior Design <span>(9)</span></a></li>
                                    </ul>
                                </div>

                                <!-- Recent Posts Section -->
                                <div class="sidebar-section">
                                    <h3 class="sidebar-title">Recent Posts</h3>
                                    <div class="recent-posts">
                                        <c:if test="${not empty allPosts}">
                                            <c:forEach items="${allPosts}" var="post" varStatus="loop" begin="0"
                                                end="2">
                                                <!-- Recent Post -->
                                                <div class="recent-post-item">
                                                    <div class="recent-post-image">
                                                        <img src="${pageContext.request.contextPath}/images/properties/${post.featuredImage}"
                                                            alt="${post.title}" loading="lazy">
                                                    </div>
                                                    <div class="recent-post-info">
                                                        <h4 class="recent-post-title">
                                                            <a
                                                                href="${pageContext.request.contextPath}/blog-detail?id=${post.postId}">${post.title}</a>
                                                        </h4>
                                                        <p class="recent-post-date">
                                                            <fmt:formatDate value="${post.createdAt}"
                                                                pattern="MMMM d, yyyy" />
                                                        </p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty allPosts}">
                                            <!-- Fallback recent posts if no posts exist -->
                                            <div class="recent-post-item">
                                                <div class="recent-post-info">
                                                    <h4 class="recent-post-title">
                                                        <a href="#">No recent posts available</a>
                                                    </h4>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Tags Section -->
                                <div class="sidebar-section">
                                    <h3 class="sidebar-title">Tags</h3>
                                    <div class="tags-list">
                                        <a href="#" class="tag">Real Estate</a>
                                        <a href="#" class="tag">Property</a>
                                        <a href="#" class="tag">Investment</a>
                                        <a href="#" class="tag">Home Buying</a>
                                        <a href="#" class="tag">Market</a>
                                        <a href="#" class="tag">Tips</a>
                                        <a href="#" class="tag">Nepal</a>
                                        <a href="#" class="tag">Kathmandu</a>
                                        <a href="#" class="tag">Apartment</a>
                                        <a href="#" class="tag">House</a>
                                    </div>
                                </div>

                                <!-- Newsletter Section -->
                                <div class="sidebar-section">
                                    <h3 class="sidebar-title">Newsletter</h3>
                                    <p>Subscribe to our newsletter to get the latest updates and news.</p>
                                    <form class="newsletter-form">
                                        <input type="email" placeholder="Your email address" required>
                                        <button type="submit" class="btn btn-primary">Subscribe</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Footer Component Placeholder -->
                 <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <h2>Ghar Dalali</h2>
                    <p>Your trusted partner in finding the perfect home.</p>
                </div>
                <div class="footer-links">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/view?page=home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=properties">Properties</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=aboutus">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=blog">Blog</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=contact">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=terms">Terms of Service</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=policy">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h3>Contact Us</h3>
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                            </path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        info@ghardalali.com
                    </p>
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path
                                d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z">
                            </path>
                        </svg>
                        +977 1234567890
                    </p>
                    <div class="social-links">
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
                            </svg>
                        </a>
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <path
                                    d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z">
                                </path>
                            </svg>
                        </a>
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                                <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Ghar Dalali. All rights reserved.</p>
            </div>
        </div>
    </footer>

                <script src="${pageContext.request.contextPath}/js/main.js"></script>
                <script src="${pageContext.request.contextPath}/js/glassmorphism.js"></script>
            </body>

            </html>