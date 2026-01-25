/**
 * DevAcademy - Main JavaScript
 * Custom functionality for the learning platform
 */

(function () {
  "use strict";

  // Initialize when DOM is ready
  document.addEventListener("DOMContentLoaded", function () {
    initNavbar();
    initScrollToTop();
    initCourseCards();
    initVideoPlayer();
    initAccordions();
    initFilters();
  });

  /**
   * Navbar scroll effect
   */
  function initNavbar() {
    const navbar = document.querySelector(".navbar");
    if (!navbar) return;

    let lastScroll = 0;
    window.addEventListener("scroll", function () {
      const currentScroll = window.pageYOffset;

      if (currentScroll > 100) {
        navbar.classList.add("shadow");
      } else {
        navbar.classList.remove("shadow");
      }

      lastScroll = currentScroll;
    });
  }

  /**
   * Scroll to top button
   */
  function initScrollToTop() {
    // Create scroll to top button
    const scrollBtn = document.createElement("button");
    scrollBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
    scrollBtn.className =
      "btn btn-primary rounded-circle position-fixed bottom-0 end-0 m-4 d-none";
    scrollBtn.style.cssText =
      "width: 50px; height: 50px; z-index: 1000; box-shadow: 0 4px 8px rgba(0,0,0,0.2);";
    scrollBtn.id = "scrollToTop";
    document.body.appendChild(scrollBtn);

    // Show/hide button on scroll
    window.addEventListener("scroll", function () {
      if (window.pageYOffset > 300) {
        scrollBtn.classList.remove("d-none");
      } else {
        scrollBtn.classList.add("d-none");
      }
    });

    // Scroll to top on click
    scrollBtn.addEventListener("click", function () {
      window.scrollTo({
        top: 0,
        behavior: "smooth",
      });
    });
  }

  /**
   * Course card interactions
   */
  function initCourseCards() {
    const courseCards = document.querySelectorAll(".course-card");

    courseCards.forEach((card) => {
      card.addEventListener("mouseenter", function () {
        this.style.transform = "translateY(-8px)";
      });

      card.addEventListener("mouseleave", function () {
        this.style.transform = "translateY(0)";
      });
    });
  }

  /**
   * Video player controls
   */
  function initVideoPlayer() {
    const videoPlayer = document.querySelector(".video-player");
    if (!videoPlayer) return;

    // Play/Pause button
    const playBtn = document.querySelector(".video-player .bi-play-fill");
    if (playBtn) {
      playBtn.addEventListener("click", function () {
        const iframe = document.querySelector("iframe");
        if (iframe) {
          // Toggle play/pause (requires YouTube API for full control)
          this.classList.toggle("bi-play-fill");
          this.classList.toggle("bi-pause-fill");
        }
      });
    }

    // Progress bar update (simulated)
    const progressBar = document.querySelector(".progress-bar");
    if (progressBar) {
      // This would be updated via video API in real implementation
      setInterval(function () {
        // Simulated progress update
        const currentWidth = parseInt(progressBar.style.width) || 0;
        if (currentWidth < 100) {
          progressBar.style.width = currentWidth + 0.1 + "%";
        }
      }, 1000);
    }
  }

  /**
   * Accordion enhancements
   */
  function initAccordions() {
    const accordionButtons = document.querySelectorAll(".accordion-button");

    accordionButtons.forEach((button) => {
      button.addEventListener("click", function () {
        const icon = this.querySelector(".bi-chevron-up, .bi-chevron-down");
        if (icon) {
          icon.classList.toggle("bi-chevron-up");
          icon.classList.toggle("bi-chevron-down");
        }
      });
    });
  }

  /**
   * Filter functionality
   */
  function initFilters() {
    const filterCheckboxes = document.querySelectorAll(
      'input[type="checkbox"]',
    );
    const clearFilterBtn = document.querySelector(".btn-clear-filter");

    if (clearFilterBtn) {
      clearFilterBtn.addEventListener("click", function () {
        filterCheckboxes.forEach((cb) => (cb.checked = false));
        updateCourseList();
      });
    }

    filterCheckboxes.forEach((checkbox) => {
      checkbox.addEventListener("change", updateCourseList);
    });
  }

  /**
   * Update course list based on filters
   */
  function updateCourseList() {
    // This would filter courses based on selected filters
    // In a real implementation, this would make an API call or filter DOM elements
    console.log("Filters updated - course list would be refreshed");
  }

  /**
   * Mark lesson as completed
   */
  function markLessonComplete(lessonId) {
    const checkbox = document.querySelector(`input[data-lesson="${lessonId}"]`);
    if (checkbox) {
      checkbox.checked = true;
      // Save to localStorage or send to server
      localStorage.setItem(`lesson_${lessonId}`, "completed");
    }
  }

  /**
   * Load lesson progress
   */
  function loadLessonProgress() {
    const checkboxes = document.querySelectorAll(
      'input[type="checkbox"][data-lesson]',
    );
    checkboxes.forEach((checkbox) => {
      const lessonId = checkbox.getAttribute("data-lesson");
      if (localStorage.getItem(`lesson_${lessonId}`) === "completed") {
        checkbox.checked = true;
      }
    });
  }

  /**
   * Smooth scroll for anchor links
   */
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      const href = this.getAttribute("href");
      if (href !== "#" && href.length > 1) {
        const target = document.querySelector(href);
        if (target) {
          e.preventDefault();
          target.scrollIntoView({
            behavior: "smooth",
            block: "start",
          });
        }
      }
    });
  });

  /**
   * Lazy load images
   */
  if ("IntersectionObserver" in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const img = entry.target;
          if (img.dataset.src) {
            img.src = img.dataset.src;
            img.removeAttribute("data-src");
            observer.unobserve(img);
          }
        }
      });
    });

    document.querySelectorAll("img[data-src]").forEach((img) => {
      imageObserver.observe(img);
    });
  }

  /**
   * Search functionality
   */
  const searchInput = document.querySelector('input[type="search"]');
  if (searchInput) {
    let searchTimeout;
    searchInput.addEventListener("input", function () {
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
    console.log("Searching for:", query);
  }

  /**
   * Initialize tooltips
   */
  const tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]'),
  );
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  /**
   * Initialize popovers
   */
  const popoverTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="popover"]'),
  );
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl);
  });
})();
