(function () {
    function escapeHtml(str) {
        return String(str || "")
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll("\"", "&quot;")
            .replaceAll("'", "&#039;");
    }

    function debounce(fn, delay) {
        let timer = null;
        return function (...args) {
            if (timer) clearTimeout(timer);
            timer = setTimeout(() => fn.apply(this, args), delay);
        };
    }

    function buildKeywordItem(keyword) {
        const safeKeyword = escapeHtml(keyword);
        return `
            <a class="search-suggest-item" href="/?q=${encodeURIComponent(keyword)}">
                <i class="bi bi-search text-muted"></i>
                <span>${safeKeyword}</span>
            </a>
        `;
    }

    function buildCourseItem(course) {
        const safeName = escapeHtml(course.name);
        const safeAuthor = escapeHtml(course.author);
        const thumb = course.thumbnail ? `/images/course/${encodeURIComponent(course.thumbnail)}` : "";
        return `
            <a class="search-suggest-item" href="/course/${course.id}">
                <img class="search-suggest-thumb" src="${thumb}" alt="${safeName}" onerror="this.style.display='none'">
                <div>
                    <div class="search-suggest-title">${safeName}</div>
                    <div class="search-suggest-meta">Khóa học · ${safeAuthor}</div>
                </div>
            </a>
        `;
    }

    function buildAuthorItem(author) {
        const safeAuthor = escapeHtml(author);
        return `
            <a class="search-suggest-item" href="/?q=${encodeURIComponent(author)}">
                <i class="bi bi-person-circle text-muted"></i>
                <div>
                    <div class="search-suggest-title">${safeAuthor}</div>
                    <div class="search-suggest-meta">Giảng viên</div>
                </div>
            </a>
        `;
    }

    function renderSuggestions(box, payload) {
        const keywords = payload?.keywords || [];
        const courses = payload?.courses || [];
        const authors = payload?.authors || [];

        let html = "";
        if (keywords.length) {
            html += `<div class="search-suggest-section">Gợi ý tìm kiếm</div>`;
            html += keywords.map(buildKeywordItem).join("");
        }
        if (courses.length) {
            html += `<div class="search-suggest-section">Khóa học nổi bật</div>`;
            html += courses.map(buildCourseItem).join("");
        }
        if (authors.length) {
            html += `<div class="search-suggest-section">Giảng viên</div>`;
            html += authors.map(buildAuthorItem).join("");
        }

        if (!html) {
            html = `<div class="search-suggest-item text-muted">Không có gợi ý phù hợp.</div>`;
        }

        box.innerHTML = html;
        box.classList.remove("d-none");
    }

    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("globalSearchInput");
        const box = document.getElementById("globalSearchSuggestions");
        if (!input || !box) return;

        const fetchSuggestions = debounce(async function () {
            const q = input.value.trim();
            if (!q) {
                box.classList.add("d-none");
                box.innerHTML = "";
                return;
            }
            try {
                const resp = await fetch(`/api/search/suggestions?q=${encodeURIComponent(q)}`);
                if (!resp.ok) throw new Error("failed");
                const data = await resp.json();
                renderSuggestions(box, data);
            } catch (e) {
                box.classList.add("d-none");
            }
        }, 220);

        input.addEventListener("input", fetchSuggestions);
        input.addEventListener("focus", function () {
            if (box.innerHTML.trim()) {
                box.classList.remove("d-none");
            }
        });

        document.addEventListener("click", function (event) {
            const wrap = document.getElementById("globalSearchForm");
            if (!wrap) return;
            if (!wrap.contains(event.target)) {
                box.classList.add("d-none");
            }
        });
    });
})();
