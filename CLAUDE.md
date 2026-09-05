# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
- This is Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront.

**Purpose:** Students learn Linux basics, Nginx hosting, and production-style deployment checks.

**Tech Stack:**Pure HTML5 plus CSS3 (no JAvascript, no build step, no frameworks)
---

## Repository Structure

```
.
├── index.html           # Main portfolio page (613 lines)
├── style.css           # All styling for the site (1145 lines)
├── privacy.html        # Privacy policy page
├── terms.html          # Terms of service page
├── images/             # Assets used in the site
│   ├── logo.png
│   ├── profile.jpg
│   ├── signature.png
│   └── [course/tech logos]
└── README.md           # User-facing deployment instructions
```

**Key Files:**
- **index.html**: Main entry point. Contains navbar, hero section, courses, books, and contact info. Links to external resources (blog, university).
- **style.css**: All responsive CSS including navbar, mobile menu toggle, smooth scrolling, and layout styling.
- **privacy.html & terms.html**: Static pages linked in footer.

---

## Development & Testing

Since this is a static site with no build process, you can test locally by:

1. **Opening in browser:** `file:///path/to/index.html` (basic testing)
2. **Using a local HTTP server:**
   ```bash
   # Python 3
   python -m http.server 8000
   # Python 2
   python -m SimpleHTTPServer 8000
   # Or using Node.js (if available)
   npx http-server
   ```
   Then visit `http://localhost:8000`

3. **Making changes:** Edit HTML/CSS directly. Changes are immediately visible on refresh (no compilation).

**Validation:**
- Browser DevTools (F12) to check responsive design
- Test on mobile devices or use browser's mobile view
- Check for broken external links (university.pravinmishra.in, blog.pravinmishra.com)

---

## Important DMI Rule: Ownership Proof

**This is mandatory for DMI students before deployment.**

The footer must be edited to add personal deployment information.

**Original footer (lines ~600 in index.html):**
```html
<p>Crafted with <span>cloud</span> excellence by Pravin Mishra</p>
```

**Must be updated to include:**
```html
<p><strong>Deployed by:</strong> [Your Name] | [Group] | [Week] | [Date]</p>
```

This proof must be **visible in browser screenshots** when submitted.

---

## Deployment

The README.md contains student-facing deployment instructions. When deployed:

1. Files are served via **Nginx** on an **Ubuntu VM**
2. Accessed via `http://<public-ip>`
3. Must remain live for 24 hours (proof for DMI)

**For local deployment testing**, use the HTTP server commands above.

---

## Customization Notes

When working on this site:
- **Navbar links** (index.html ~line 20-50): Fixed to external URLs (blog, university). Modify with caution.
- **Navigation styling** (style.css): Navbar is fixed, responsive with hamburger menu for mobile.
- **Images**: All image assets are in `images/` directory. Update `<img src="...">` paths if reorganizing.
- **External dependencies**: FontAwesome 6.5.0 loaded from CDN for icons.

##  Key Conventions/Rules
- No JavaScript allowed in the project
- Mobile-first CSS approach
- All images stored in images/


---

## Quick Commands

| Task | Command |
|------|---------|
| Start local server (Python 3) | `python -m http.server 8000` |
| Start local server (Node) | `npx http-server` |
| View site | `http://localhost:8000` (or `file:///path/to/index.html`) |
| Deploy | Follow README.md (Nginx on Ubuntu) |
