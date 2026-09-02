#!/bin/bash
# Sitewide fix script — runs on server
# Skips: __drafts__, __manus__, .min.js, non-HTML files
ROOT="/home/customer/www/handyman.ae/public_html"
cd "$ROOT"

echo "=== FIX START $(date) ==="

# Build list of HTML index files only (no drafts, no manus)
TMPLIST="/tmp/html_files.txt"
find . -name "index.html" \
  -not -path "*/__drafts__/*" \
  -not -path "*/__manus__/*" \
  > "$TMPLIST"
TOTAL=$(wc -l < "$TMPLIST")
echo "Total HTML files: $TOTAL"

# ---- FIX 1: ratingValue 4.9 → 5.0 in schema JSON ----
echo ""
echo "--- Fix 1: ratingValue 4.9 → 5.0 ---"
BEFORE=$(xargs grep -c '"ratingValue".*4\.9\|ratingValue.*"4\.9"' < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE files with ratingValue 4.9"
xargs sed -i 's/"ratingValue": "4\.9"/"ratingValue": "5.0"/g' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/"ratingValue":"4\.9"/"ratingValue":"5.0"/g' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -c '"ratingValue".*4\.9\|ratingValue.*"4\.9"' < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER files with ratingValue 4.9"

# ---- FIX 2: Visible 4.9 star text ----
echo ""
echo "--- Fix 2: visible 4.9 star text ---"
BEFORE=$(xargs grep -ic "4\.9 star\|4\.9-star\|4\.9/5\|rated 4\.9\|4\.9 out of" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i 's/4\.9 stars/5.0 stars/gi' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/4\.9-star/5.0-star/gi' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/4\.9\/5/5.0\/5/gi' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/rated 4\.9/rated 5.0/gi' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/4\.9 out of/5.0 out of/gi' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "4\.9 star\|4\.9-star\|4\.9/5\|rated 4\.9\|4\.9 out of" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

# ---- FIX 3: 47+ → 46 (community count in text/meta/schema) ----
echo ""
echo "--- Fix 3: 47+ → 46 communities ---"
BEFORE=$(xargs grep -c "47+" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances of '47+'"
xargs sed -i 's/47+ Dubai communities/46 Dubai communities/g' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/47+ communities/46 communities/g' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/across 47+/across 46/g' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/47+ areas/46 areas/g' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/47+/46/g' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -c "47+" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances of '47+'"

# ---- FIX 4: 47 communities text ----
echo ""
echo "--- Fix 4: '47 communities' text ---"
BEFORE=$(xargs grep -ic "47 communit\|47 dubai communit" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i 's/47 Dubai communities/46 Dubai communities/gi' < "$TMPLIST" 2>/dev/null
xargs sed -i 's/47 communities/46 communities/gi' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "47 communit\|47 dubai communit" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

# ---- FIX 5: Old brand tagline ----
echo ""
echo "--- Fix 5: old brand tagline ---"
BEFORE=$(xargs grep -ic "Dubai's home is Handyman.ae's job" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i "s/Dubai's home is Handyman\.ae's job\./Dubai's handyman./g" < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "Dubai's home is Handyman.ae's job" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

# ---- FIX 6: Banned phrase 'professional team' ----
echo ""
echo "--- Fix 6: 'professional team' → 'licensed technicians' ---"
BEFORE=$(xargs grep -ic "professional team" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i 's/professional team/licensed technicians/gi' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "professional team" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

# ---- FIX 7: Banned phrase 'home maintenance needs' ----
echo ""
echo "--- Fix 7: 'home maintenance needs' → 'home maintenance requirements' ---"
BEFORE=$(xargs grep -ic "home maintenance needs" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i 's/home maintenance needs/home maintenance requirements/gi' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "home maintenance needs" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

# ---- FIX 8: Banned phrase 'one-stop shop' ----
echo ""
echo "--- Fix 8: 'one-stop shop' → 'single-provider solution' ---"
BEFORE=$(xargs grep -ic "one-stop shop" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "Before: $BEFORE instances"
xargs sed -i 's/one-stop shop/single-provider solution/gi' < "$TMPLIST" 2>/dev/null
AFTER=$(xargs grep -ic "one-stop shop" < "$TMPLIST" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "After: $AFTER instances"

echo ""
echo "=== FIX COMPLETE $(date) ==="
