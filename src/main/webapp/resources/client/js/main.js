/**
 * DevAcademy - Main JavaScript
 * Custom functionality for the learning platform
 */

(function() {
    'use strict';

    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initAuth();
        initCart();
        initNavbar();
        initScrollToTop();
        initCourseCards();
        initVideoPlayer();
        initAccordions();
        initFilters();
    });

    /**
     * =========================
     * Auth (localStorage demo)
     * =========================
     */
    const AUTH_KEY = 'devacademy_current_user';

    function getCurrentUser() {
        try {
            const raw = localStorage.getItem(AUTH_KEY);
            return raw ? JSON.parse(raw) : null;
        } catch (e) {
            return null;
        }
    }

    function setCurrentUser(user) {
        if (!user) {
            localStorage.removeItem(AUTH_KEY);
            return;
        }
        localStorage.setItem(AUTH_KEY, JSON.stringify(user));
    }

    function initAuth() {
        // Handle sign-in form
        const signInForm = document.querySelector('[data-page="signin"] form[data-auth-form="signin"]');
        if (signInForm) {
            signInForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const email = signInForm.querySelector('input[name="email"]')?.value?.trim() || '';
                const password = signInForm.querySelector('input[name="password"]')?.value || '';

                if (!email || !password) {
                    showAuthAlert(signInForm, 'Vui lòng nhập đầy đủ Email và Mật khẩu.', 'danger');
                    return;
                }

                setCurrentUser({ fullName: email.split('@')[0] || 'Học viên', email });
                showAuthAlert(signInForm, 'Đăng nhập thành công! Đang chuyển hướng...', 'success');
                setTimeout(() => {
                    window.location.href = 'index.html';
                }, 600);
            });
        }

        // Handle sign-up form
        const signUpForm = document.querySelector('[data-page="signup"] form[data-auth-form="signup"]');
        if (signUpForm) {
            signUpForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const fullName = signUpForm.querySelector('input[name="fullName"]')?.value?.trim() || '';
                const email = signUpForm.querySelector('input[name="email"]')?.value?.trim() || '';
                const password = signUpForm.querySelector('input[name="password"]')?.value || '';
                const confirm = signUpForm.querySelector('input[name="confirmPassword"]')?.value || '';

                if (!fullName || !email || !password || !confirm) {
                    showAuthAlert(signUpForm, 'Vui lòng nhập đầy đủ thông tin.', 'danger');
                    return;
                }
                if (password.length < 6) {
                    showAuthAlert(signUpForm, 'Mật khẩu cần tối thiểu 6 ký tự.', 'danger');
                    return;
                }
                if (password !== confirm) {
                    showAuthAlert(signUpForm, 'Xác nhận mật khẩu không khớp.', 'danger');
                    return;
                }

                setCurrentUser({ fullName, email });
                showAuthAlert(signUpForm, 'Tạo tài khoản thành công! Đang chuyển hướng...', 'success');
                setTimeout(() => {
                    window.location.href = 'index.html';
                }, 600);
            });
        }

        // Global sign-out buttons/links
        document.addEventListener('click', function(e) {
            const target = e.target.closest('[data-action="signout"]');
            if (!target) return;
            e.preventDefault();
            setCurrentUser(null);
            // Keep user on same page, but refresh UI
            window.location.href = 'index.html';
        });

        renderAuthUI();
    }

    function showAuthAlert(formEl, message, type) {
        let alert = formEl.querySelector('[data-auth-alert]');
        if (!alert) {
            alert = document.createElement('div');
            alert.setAttribute('data-auth-alert', '1');
            alert.className = 'alert alert-danger py-2 mb-3';
            formEl.prepend(alert);
        }
        alert.className = `alert alert-${type} py-2 mb-3`;
        alert.textContent = message;
    }

    function renderAuthUI() {
        const user = getCurrentUser();

        // Navbar guest buttons (optional)
        const guestArea = document.querySelector('[data-auth-area="guest"]');
        const userArea = document.querySelector('[data-auth-area="user"]');
        const userNameEls = document.querySelectorAll('[data-auth-user-name]');

        if (guestArea && userArea) {
            if (user) {
                guestArea.classList.add('d-none');
                userArea.classList.remove('d-none');
            } else {
                userArea.classList.add('d-none');
                guestArea.classList.remove('d-none');
            }
        }

        userNameEls.forEach(el => {
            el.textContent = user?.fullName || 'Tài khoản';
        });
    }

    /**
     * =========================
     * Cart (localStorage demo)
     * =========================
     */
    const CART_KEY = 'devacademy_cart';

    function getCartItems() {
        try {
            const raw = localStorage.getItem(CART_KEY);
            const items = raw ? JSON.parse(raw) : [];
            return Array.isArray(items) ? items : [];
        } catch (e) {
            return [];
        }
    }

    function setCartItems(items) {
        localStorage.setItem(CART_KEY, JSON.stringify(items || []));
        updateCartBadges();
    }

    function getCartCount() {
        return getCartItems().reduce((sum, it) => sum + (Number(it?.qty) || 0), 0);
    }

    function formatPriceVnd(value) {
        const n = Number(value) || 0;
        return `${Math.round(n).toLocaleString('vi-VN')} đ`;
    }

    function updateCartBadges() {
        const count = getCartCount();
        document.querySelectorAll('[data-cart-badge]').forEach(badge => {
            badge.textContent = String(count);
            badge.classList.toggle('d-none', count <= 0);
        });
    }

    function initCart() {
        updateCartBadges();

        // If cart page exists, render empty state / list
        const cartPage = document.querySelector('[data-page="cart"]');
        if (cartPage) {
            renderCartPage();
        }

        // Demo: any button with data-action="add-to-cart"
        document.addEventListener('click', function(e) {
            const btn = e.target.closest('[data-action="add-to-cart"]');
            if (!btn) return;
            e.preventDefault();
            const id = btn.getAttribute('data-course-id') || 'course';
            const title = btn.getAttribute('data-course-title') || 'Khóa học';
            const priceNumber = Number(btn.getAttribute('data-course-price-number') || 0);
            const author = btn.getAttribute('data-course-author') || '';
            const level = btn.getAttribute('data-course-level') || '';
            const image = btn.getAttribute('data-course-image') || '';

            const items = getCartItems();
            const existing = items.find(it => it.id === id);
            if (existing) existing.qty = (Number(existing.qty) || 1) + 1;
            else items.push({ id, title, priceNumber, author, level, image, qty: 1 });
            setCartItems(items);
        });

        document.addEventListener('click', function(e) {
            const clearBtn = e.target.closest('[data-action="clear-cart"]');
            if (!clearBtn) return;
            e.preventDefault();
            setCartItems([]);
            renderCartPage();
        });
    }

    function renderCartPage() {
        const items = getCartItems();
        const emptyEl = document.querySelector('[data-cart-empty]');
        const listSectionEl = document.querySelector('[data-cart-list]');
        const listItemsEl = document.querySelector('[data-cart-items]');
        const countLabelEl = document.querySelector('[data-cart-count-label]');
        const totalEl = document.querySelector('[data-cart-total]');

        if (!emptyEl || !listSectionEl || !listItemsEl) return;

        if (!items.length) {
            emptyEl.classList.remove('d-none');
            listSectionEl.classList.add('d-none');
            if (countLabelEl) countLabelEl.textContent = '0';
            if (totalEl) totalEl.textContent = formatPriceVnd(0);
            return;
        }

        emptyEl.classList.add('d-none');
        listSectionEl.classList.remove('d-none');
        const total = items.reduce((sum, it) => {
            const qty = Number(it.qty) || 1;
            const price = Number(it.priceNumber) || 0;
            return sum + price * qty;
        }, 0);
        if (countLabelEl) countLabelEl.textContent = String(items.length);
        if (totalEl) totalEl.textContent = formatPriceVnd(total);

        listItemsEl.innerHTML = items.map(it => {
            const safeTitle = escapeHtml(it.title || 'Khóa học');
            const safeAuthor = escapeHtml(it.author || 'Giảng viên');
            const safeLevel = escapeHtml(it.level || 'Tất cả cấp độ');
            const safeImage = escapeHtml(it.image || '/images/course/default.jpg');
            const qty = Number(it.qty) || 1;
            const linePrice = (Number(it.priceNumber) || 0) * qty;
            return `
                <div class="cart-course-item">
                    <div class="d-flex justify-content-between gap-3">
                        <div class="d-flex gap-3 flex-grow-1">
                            <img src="${safeImage}" alt="${safeTitle}" class="cart-thumb" />
                            <div>
                                <h6 class="fw-bold mb-1">${safeTitle}</h6>
                                <div class="text-muted small mb-1">${safeAuthor}</div>
                                <div class="text-muted small">${safeLevel} • SL: ${qty}</div>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="fw-bold">${formatPriceVnd(linePrice)}</div>
                            <button class="btn btn-link btn-sm text-danger p-0 mt-1" data-action="remove-cart-item" data-item-id="${escapeHtml(it.id)}">
                                Xóa
                            </button>
                        </div>
                    </div>
                </div>    
            `;
        }).join('');

        // remove handlers
        listItemsEl.querySelectorAll('[data-action="remove-cart-item"]').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.getAttribute('data-item-id');
                const next = getCartItems().filter(it => it.id !== id);
                setCartItems(next);
                renderCartPage();
            });
        });
    }

    function escapeHtml(str) {
        return String(str)
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#039;');
    }

    /**
     * Navbar scroll effect
     */
    function initNavbar() {
        const navbar = document.querySelector('.navbar');
        if (!navbar) return;

        let lastScroll = 0;
        window.addEventListener('scroll', function() {
            const currentScroll = window.pageYOffset;

            if (currentScroll > 100) {
                navbar.classList.add('shadow');
            } else {
                navbar.classList.remove('shadow');
            }

            lastScroll = currentScroll;
        });
    }

    /**
     * Scroll to top button
     */
    function initScrollToTop() {
        // Create scroll to top button
        const scrollBtn = document.createElement('button');
        scrollBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
        scrollBtn.className = 'btn btn-primary rounded-circle position-fixed bottom-0 end-0 m-4 d-none';
        scrollBtn.style.cssText = 'width: 50px; height: 50px; z-index: 1000; box-shadow: 0 4px 8px rgba(0,0,0,0.2);';
        scrollBtn.id = 'scrollToTop';
        document.body.appendChild(scrollBtn);

        // Show/hide button on scroll
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                scrollBtn.classList.remove('d-none');
            } else {
                scrollBtn.classList.add('d-none');
            }
        });

        // Scroll to top on click
        scrollBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    /**
     * Course card interactions
     */
    function initCourseCards() {
        const courseCards = document.querySelectorAll('.course-card');
        
        courseCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    }

    /**
     * Video player controls
     */
    function initVideoPlayer() {
        const videoPlayer = document.querySelector('.video-player');
        if (!videoPlayer) return;

        // Play/Pause button
        const playBtn = document.querySelector('.video-player .bi-play-fill');
        if (playBtn) {
            playBtn.addEventListener('click', function() {
                const iframe = document.querySelector('iframe');
                if (iframe) {
                    // Toggle play/pause (requires YouTube API for full control)
                    this.classList.toggle('bi-play-fill');
                    this.classList.toggle('bi-pause-fill');
                }
            });
        }

        // Progress bar update (simulated)
        const progressBar = document.querySelector('.progress-bar');
        if (progressBar) {
            // This would be updated via video API in real implementation
            setInterval(function() {
                // Simulated progress update
                const currentWidth = parseInt(progressBar.style.width) || 0;
                if (currentWidth < 100) {
                    progressBar.style.width = (currentWidth + 0.1) + '%';
                }
            }, 1000);
        }
    }

    /**
     * Accordion enhancements
     */
    function initAccordions() {
        const accordionButtons = document.querySelectorAll('.accordion-button');
        
        accordionButtons.forEach(button => {
            button.addEventListener('click', function() {
                const icon = this.querySelector('.bi-chevron-up, .bi-chevron-down');
                if (icon) {
                    icon.classList.toggle('bi-chevron-up');
                    icon.classList.toggle('bi-chevron-down');
                }
            });
        });
    }

    /**
     * Filter functionality
     */
    function initFilters() {
        const filterCheckboxes = document.querySelectorAll('input[type="checkbox"]');
        const clearFilterBtn = Array.from(document.querySelectorAll('button'))
            .find(btn => (btn.textContent || '').trim().toLowerCase() === 'xóa bộ lọc');
        
        if (clearFilterBtn) {
            clearFilterBtn.addEventListener('click', function() {
                filterCheckboxes.forEach(checkbox => {
                    checkbox.checked = false;
                });
                // Trigger filter update
                updateCourseList();
            });
        }

        filterCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                updateCourseList();
            });
        });
    }

    /**
     * Update course list based on filters
     */
    function updateCourseList() {
        // This would filter courses based on selected filters
        // In a real implementation, this would make an API call or filter DOM elements
        console.log('Filters updated - course list would be refreshed');
    }

    /**
     * Mark lesson as completed
     */
    function markLessonComplete(lessonId) {
        const checkbox = document.querySelector(`input[data-lesson="${lessonId}"]`);
        if (checkbox) {
            checkbox.checked = true;
            // Save to localStorage or send to server
            localStorage.setItem(`lesson_${lessonId}`, 'completed');
        }
    }

    /**
     * Load lesson progress
     */
    function loadLessonProgress() {
        const checkboxes = document.querySelectorAll('input[type="checkbox"][data-lesson]');
        checkboxes.forEach(checkbox => {
            const lessonId = checkbox.getAttribute('data-lesson');
            if (localStorage.getItem(`lesson_${lessonId}`) === 'completed') {
                checkbox.checked = true;
            }
        });
    }

    /**
     * Smooth scroll for anchor links
     */
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href !== '#' && href.length > 1) {
                const target = document.querySelector(href);
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
        });
    });

    /**
     * Lazy load images
     */
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        observer.unobserve(img);
                    }
                }
            });
        });

        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }

    /**
     * Search functionality
     */
    const searchInput = document.querySelector('input[type="search"]');
    if (searchInput) {
        let searchTimeout;
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length > 2) {
                searchTimeout = setTimeout(() => {
                    performSearch(query);
                }, 300);
            }
        });
    }

    function performSearch(query) {
        // This would make an API call to search courses
        console.log('Searching for:', query);
    }

    /**
     * Initialize tooltips
     */
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    /**
     * Initialize popovers
     */
    const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    popoverTriggerList.map(function(popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });

})();
