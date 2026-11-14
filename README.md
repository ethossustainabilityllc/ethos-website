# ETHOS Sustainability website

Static rebuild of `ethossustainability.godaddysites.com`, ready for GitHub Pages at `ethossustainability.com`.

Plain HTML, one CSS file, one small JS file. No build step, no frameworks, no calls to GoDaddy or Google. Every image and font lives in this repo.

## Pages

URLs match the GoDaddy site exactly, so old links keep working.

| URL | File | In main nav |
|---|---|---|
| `/` | `index.html` | Home |
| `/solutions` | `solutions.html` | Solutions |
| `/team` | `team.html` | Team |
| `/contact` | `contact.html` | Contact |
| `/strategy` | `strategy.html` | linked from Solutions |
| `/efficiencydecarb` | `efficiencydecarb.html` | linked from Solutions |
| `/analysisreporting` | `analysisreporting.html` | linked from Solutions |
| `/implementation` | `implementation.html` | linked from Solutions |
| `/policyregulation` | `policyregulation.html` | linked from Solutions |
| `/resilience` | `resilience.html` | linked from Solutions |
| `/engagement` | `engagement.html` | linked from Solutions |
| `/advanced` | `advanced.html` | linked from Solutions |

GitHub Pages serves `solutions.html` at `/solutions` with no redirect. `404.html` catches anything else.

## Layout

```
assets/css/fonts.css   self-hosted Source Sans Pro + Playfair Display
assets/css/site.css    all styles; GoDaddy breakpoints 768 / 1024 / 1280 / 1536
assets/js/site.js      mobile menu + mailto forms
assets/fonts/          woff2 files + OFL licenses
assets/img/            logo, hero, favicons, solution tiles, team photo
scripts/fetch-images.sh  optional: re-download images from GoDaddy while it is still live
CNAME                  ethossustainability.com
.nojekyll              serve files as-is
robots.txt, sitemap.xml
```

## Deploy

1. Create a GitHub repo and push this folder as the repo root.
2. Repo **Settings > Pages**: Source = "Deploy from a branch", branch `main`, folder `/ (root)`.
3. Same page, **Custom domain**: `ethossustainability.com` (the `CNAME` file already sets this).
4. At your DNS host, point the apex domain at GitHub Pages:
   - `A` records for `@`: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - `AAAA` records for `@` (optional): `2606:50c0:8000::153`, `2606:50c0:8001::153`, `2606:50c0:8002::153`, `2606:50c0:8003::153`
   - `CNAME` for `www`: `<your-github-username>.github.io`
5. After DNS resolves, tick **Enforce HTTPS**.
6. Cancel the GoDaddy site only after the new site loads on your domain.

Check GitHub's current docs before changing DNS: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site

All links in pages are relative, so the site also works at `https://<user>.github.io/<repo>/` before the domain moves. Exception: `404.html` uses root links and only works right on the custom domain.

## Preview locally

```
python3 -m http.server 8000
```
Open `http://localhost:8000/index.html`. Note: Python's server does not map `/solutions` to `solutions.html`, so nav clicks 404 locally. GitHub Pages does map them.

## Editing

- Text: edit the HTML file for that page. Header and footer repeat in every file; change all 13 if you change nav or copyright.
- Colors and sizes: CSS variables at the top of `assets/css/site.css`.
- Contact email: `CONTACT_EMAIL` in `assets/js/site.js` plus the link in `contact.html`.

## QA/QC report (Nov 12, 2026)

Method: measured every key element on the live GoDaddy site at 375, 900, 1280 and 1550 px wide, then measured the rebuild at the same widths in headless Chrome and compared.

**Matches original (within 1 px vertical):**
- Desktop 1280: all 5 page types (Home, Solutions, sub-pages, Team, Contact). Header 123, hero 234, title, columns, buttons, footer 111.
- Mobile 375: header 91, hero 272, all headings, columns, buttons, contact block.
- Tablet 900: sub-pages, Team, Contact.
- Wide 1550: font scale-up (hero 64 px, headings 36/48 px, body 18 px, tiles 272 px).
- Fonts: same families and weights. Colors: same hex values. Hover: nav fades to 50%, buttons go black.
- Images: byte-for-byte the WebP/JPEG/SVG files GoDaddy serves to modern browsers, same crops.

**Functional tests passed:**
- All 12 pages load, all internal links return 200, every image loads.
- Zero network requests leave the site on page load (no GoDaddy, no Google).
- Unknown URL returns the 404 page.
- Mobile menu opens and closes (button, close X, Escape key).
- Contact form blocks empty submit, then opens the visitor's email app pre-filled with name, email, phone, message.
- Subscribe form opens email app with a sign-up request.

**Intentional differences:**
1. Contact form sends through the visitor's email app (mailto), not a server. The reCAPTCHA notice under Send is gone; its space is kept so the layout matches.
2. Subscribe form on `/implementation` also uses mailto.
3. "Powered by GoDaddy Airo" footer badge removed. Desktop footer keeps its height; mobile footer is about 45 px shorter.
4. Cookie banner removed. The new site sets no cookies and has no analytics.
5. Headings that wrap to two lines (for example "Marketing & Engagement Development") make their cell taller. GoDaddy let them overlap via script. Affects a few sub-page cells by up to 27 px.

**Fixed after first review (content changes from the GoDaddy original):**
- Typos: "Analyis" now "Analysis" (`/analysisreporting`), "Implemenation" now "Implementation" (`/implementation`), "through through" now "through" (Team), "help your meet your" now "help you meet your" (Home).
- Removed the placeholder "." under every sub-page service heading. Each service now shows its heading only. Add real descriptions later inside each `.service` block as `<div class="rich"><p>...</p></div>`.
- "Contact Us" on `/efficiencydecarb` and `/analysisreporting` now goes to `/contact`.
- Copyright updated to 2026.
- `og:locale` now `en_US`; page language `en-US`.
- New `assets/img/social-share.png` (1200x630, logo on white) for LinkedIn, Facebook and X link previews. `twitter:card` is now `summary_large_image`.

**Re-tested after fixes:** all links, zero external requests, menu, both forms, and Home layout at 375 / 900 / 1280 px all match the original positions (tablet Home now verified).
