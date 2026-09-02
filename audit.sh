#!/bin/bash
# Audit script — runs on server, outputs counts only
ROOT="/home/customer/www/handyman.ae/public_html"
cd "$ROOT"

echo "=== AUDIT START ==="

# Only HTML index files, skip minified JS
HTML_FILES=$(find . -name "index.html" -not -path "*/__drafts__/*" -not -path "*/__manus__/*")
HTML_COUNT=$(echo "$HTML_FILES" | wc -l)
echo "HTML files to audit: $HTML_COUNT"

# 1. 47+ community mentions (in visible text / meta / schema — not JS coords)
echo ""
echo "--- 47+ mentions ---"
echo "$HTML_FILES" | xargs grep -l "47+" 2>/dev/null | wc -l
echo "files containing '47+'"
echo "$HTML_FILES" | xargs grep -c "47+" 2>/dev/null | grep -v ":0" | head -20

# 2. 4.9 rating in schema/meta (ratingValue or visible text — not JS coords)
echo ""
echo "--- ratingValue 4.9 in schema ---"
echo "$HTML_FILES" | xargs grep -l '"ratingValue".*4\.9\|ratingValue.*"4\.9"' 2>/dev/null | wc -l
echo "files with ratingValue 4.9"

echo ""
echo "--- visible 4.9 stars text ---"
echo "$HTML_FILES" | xargs grep -il "4\.9 star\|4\.9-star\|4\.9/5\|rated 4\.9\|4\.9 out of" 2>/dev/null | wc -l
echo "files with visible 4.9 star text"

# 3. Banned phrases
echo ""
echo "--- banned phrases ---"
for phrase in "go-to handyman" "professional team" "top-quality results" "home maintenance needs" "your trusted handyman" "one-stop shop" "quality you can count on"; do
    count=$(echo "$HTML_FILES" | xargs grep -ic "$phrase" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
    files=$(echo "$HTML_FILES" | xargs grep -il "$phrase" 2>/dev/null | wc -l)
    echo "  '$phrase': $count instances in $files files"
done

# 4. Old brand tagline
echo ""
echo "--- old brand tagline ---"
old_count=$(echo "$HTML_FILES" | xargs grep -ic "Dubai's home is Handyman.ae's job" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "  'Dubai's home is Handyman.ae's job': $old_count instances"

# 5. Old @id #business
echo ""
echo "--- @id #business (should be #organization) ---"
biz=$(echo "$HTML_FILES" | xargs grep -c '"#business"' 2>/dev/null | grep -v ":0" | wc -l)
echo "  files still using #business: $biz"

# 6. Community count 47
echo ""
echo "--- '47 communities' or '47 Dubai' in visible text ---"
c47=$(echo "$HTML_FILES" | xargs grep -ic "47 communit\|47 dubai communit" 2>/dev/null | awk -F: '{sum+=$2} END{print sum}')
echo "  instances: $c47"

echo ""
echo "=== AUDIT END ==="
