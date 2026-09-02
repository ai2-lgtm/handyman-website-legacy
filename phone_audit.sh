#!/bin/bash
# Phone-number sweep — all formats, all file types
ROOT=/home/customer/www/handyman.ae/public_html
cd $ROOT

echo "=== ROOT FILES ==="
ls -la robots.txt llms.txt sitemap.xml .htaccess 2>/dev/null | awk '{print $9}'

echo ""
echo "=== HTML FILES — count instances per old number ==="
echo "559963713 (any format):"
grep -rl "559963713" --include="*.html" . 2>/dev/null | wc -l
echo "55 996 3713 (with spaces):"
grep -rl "55 996 3713" --include="*.html" . 2>/dev/null | wc -l
echo "055 996 3713:"
grep -rl "055 996 3713" --include="*.html" . 2>/dev/null | wc -l
echo "6005544456:"
grep -rl "6005544456" --include="*.html" . 2>/dev/null | wc -l
echo "600 55 4456:"
grep -rl "600 55 4456" --include="*.html" . 2>/dev/null | wc -l

echo ""
echo "=== JS FILES (incl minified) ==="
echo "559963713:"
grep -rl "559963713" --include="*.js" . 2>/dev/null | wc -l
echo "6005544456:"
grep -rl "6005544456" --include="*.js" . 2>/dev/null | wc -l

echo ""
echo "=== PHP FILES ==="
grep -rl "559963713\|6005544456\|55 996 3713\|600 55 4456" --include="*.php" . 2>/dev/null | wc -l

echo ""
echo "=== CSS FILES ==="
grep -rl "559963713\|6005544456" --include="*.css" . 2>/dev/null | wc -l

echo ""
echo "=== TXT FILES (robots/llms/etc) ==="
grep -rln "559963713\|6005544456\|55 996 3713\|600 55 4456" --include="*.txt" . 2>/dev/null

echo ""
echo "=== XML (sitemap) ==="
grep -rln "559963713\|6005544456\|55 996 3713\|600 55 4456" --include="*.xml" . 2>/dev/null

echo ""
echo "=== .htaccess + dotfiles ==="
grep -rln "559963713\|6005544456\|55 996 3713\|600 55 4456" --include=".htaccess" . 2>/dev/null

echo ""
echo "=== wa.me LINKS NOT 971585836342 ==="
grep -roh "wa\.me/[0-9]*" . 2>/dev/null | sort -u

echo ""
echo "=== TOTAL FILES TO FIX ==="
grep -rl "559963713\|6005544456\|55 996 3713\|600 55 4456\|055 996 3713\|wa\.me/971559963713\|wa\.me/9716005544456" $ROOT 2>/dev/null | wc -l
