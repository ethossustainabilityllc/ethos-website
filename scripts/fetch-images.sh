#!/usr/bin/env bash
# Optional. All images are ALREADY in assets/img/. Use this only to re-download them
# from GoDaddy while the old site is still live (also grabs the 1.6 MB original hero PNG).
# Run from anywhere:  bash scripts/fetch-images.sh
# After this runs, the site has zero dependency on GoDaddy servers.
set -euo pipefail
cd "$(dirname "$0")/.."
IMG="assets/img"
mkdir -p "$IMG/solutions" "$IMG/team"

B="https://img1.wsimg.com/isteam"
IP="$B/ip/3d8b2592-306a-459e-9632-08e8970c2a2b"
WEBP=(-H "Accept: image/webp,image/*;q=0.8")

get() { # get <dest> <url> [webp]
  local dest="$1" url="$2"
  if [ "${3:-}" = "webp" ]; then
    curl -fsSL "${WEBP[@]}" -o "$dest" "$url"
  else
    curl -fsSL -o "$dest" "$url"
  fi
  printf '  %-40s %8s bytes\n' "$dest" "$(wc -c < "$dest" | tr -d ' ')"
}

echo "Downloading images from GoDaddy CDN..."
get "$IMG/logo.svg"          "$IP/ETHOS-Sustainability-Logo.svg"
get "$IMG/hero.webp"         "$IP/blob-e3f77ca.png/:/cr=t:0%25,l:0%25,w:100%25,h:100%25/rs=w:2558,m" webp
get "$IMG/hero-original.png" "$IP/blob-e3f77ca.png"

FAV="$IP/favicon/71f56d11-8e07-4202-909a-3b7b959b19d8/6f0ade0f-5b1a-447b-a664-c80e4ad1eb7e.png"
get "$IMG/favicon-16.jpg"         "$FAV/:/rs=w:16,h:16,m"
get "$IMG/favicon-32.jpg"         "$FAV/:/rs=w:32,h:32,m"
get "$IMG/favicon-64.jpg"         "$FAV/:/rs=w:64,h:64,m"
get "$IMG/apple-touch-icon.jpg"   "$FAV/:/rs=w:180,h:180,m"

# Solutions tiles: same crops GoDaddy applies, at 2x display size (730 px).
get "$IMG/solutions/strategy.webp"          "$B/stock/29GdGAG/:/cr=t:0%25,l:9.84%25,w:80.31%25,h:99.99%25/rs=w:730,h:730,cg:true,m" webp
get "$IMG/solutions/efficiencydecarb.webp"  "$B/stock/113306/:/cr=t:0%25,l:16.68%25,w:66.65%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/analysisreporting.webp" "$IP/ETHOS-Analysis.png/:/cr=t:0%25,l:16.67%25,w:66.67%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/implementation.webp"    "$IP/blob-3c7c062.png/:/cr=t:0%25,l:16.67%25,w:66.67%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/policyregulation.webp"  "$B/stock/EVx4NP/:/cr=t:0%25,l:16.67%25,w:66.67%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/resilience.webp"        "$IP/blob-b100ce0.png/:/cr=t:0%25,l:16.67%25,w:66.67%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/engagement.webp"        "$IP/Untitled%20design.png/:/cr=t:0%25,l:16.67%25,w:66.67%25,h:100%25/rs=w:730,h:730,cg:true" webp
get "$IMG/solutions/advanced.webp"          "$IP/blob-b9a4ece.png/:/cr=t:0%25,l:16.22%25,w:55.49%25,h:100%25/rs=w:730,h:730,cg:true" webp

# Team photo: same crop as GoDaddy, 2x display size.
get "$IMG/team/bill-eger.webp" "$IP/IMG_2520.JPG/:/cr=t:5.49%25,l:0%25,w:100%25,h:89.01%25/rs=w:1200,h:1600,cg:true" webp

echo "Done. All images are local. Commit assets/img/ with the rest of the site."
