#!/bin/bash
ROOT=/home/customer/www/handyman.ae/public_html
cd $ROOT

# List all affected files first for the report
AFFECTED=$(grep -rl "559963713\|6005544456\|55 996 3713\|600 55 4456\|055 996 3713\|wa\.me/971559963713\|wa\.me/9716005544456" $ROOT --include="*.html" --include="*.txt" --include="*.xml" --include="*.htaccess" 2>/dev/null)

echo "=== AFFECTED FILES ==="
echo "$AFFECTED"
echo ""
echo "=== APPLYING REPLACEMENTS ==="

# Replace each variant. Order matters — most specific first.
for f in $AFFECTED; do
    # wa.me link variants
    sed -i 's|wa\.me/971559963713|wa.me/971585836342|g' "$f"
    sed -i 's|wa\.me/9716005544456|wa.me/971585836342|g' "$f"
    sed -i 's|wa\.me/97155|wa.me/97158|g' "$f"  # any stragglers
    
    # Phone display formats
    sed -i 's|+971 55 996 3713|+971 58 583 6342|g' "$f"
    sed -i 's|+971 55 996-3713|+971 58 583 6342|g' "$f"
    sed -i 's|+971-55-996-3713|+971 58 583 6342|g' "$f"
    sed -i 's|+971559963713|+971585836342|g' "$f"
    sed -i 's|971559963713|971585836342|g' "$f"
    sed -i 's|055 996 3713|058 583 6342|g' "$f"
    sed -i 's|055-996-3713|058 583 6342|g' "$f"
    sed -i 's|0559963713|0585836342|g' "$f"
    sed -i 's|55 996 3713|58 583 6342|g' "$f"
    sed -i 's|559963713|585836342|g' "$f"
    
    # 600 number variants
    sed -i 's|+971 600 55 4456|+971 58 583 6342|g' "$f"
    sed -i 's|+971-600-55-4456|+971 58 583 6342|g' "$f"
    sed -i 's|+971600554456|+971585836342|g' "$f"
    sed -i 's|600 55 4456|58 583 6342|g' "$f"
    sed -i 's|600-55-4456|58 583 6342|g' "$f"
    sed -i 's|6005544456|585836342|g' "$f"
done

echo ""
echo "=== POST-FIX VERIFICATION ==="
echo "559963713 remaining:"
grep -rl "559963713" $ROOT --include="*.html" --include="*.txt" --include="*.xml" 2>/dev/null | wc -l
echo "6005544456 remaining:"
grep -rl "6005544456" $ROOT --include="*.html" --include="*.txt" --include="*.xml" 2>/dev/null | wc -l
echo "55 996 3713 remaining:"
grep -rl "55 996 3713" $ROOT --include="*.html" --include="*.txt" --include="*.xml" 2>/dev/null | wc -l
echo "600 55 4456 remaining:"
grep -rl "600 55 4456" $ROOT --include="*.html" --include="*.txt" --include="*.xml" 2>/dev/null | wc -l
echo "055 996 3713 remaining:"
grep -rl "055 996 3713" $ROOT --include="*.html" 2>/dev/null | wc -l
echo "wa.me variants:"
grep -roh "wa\.me/[0-9]*" $ROOT 2>/dev/null | sort -u
echo ""
echo "=== TOTAL FILES STILL CONTAINING ANY OLD NUMBER ==="
grep -rl "559963713\|6005544456\|55 996 3713\|600 55 4456\|055 996 3713" $ROOT 2>/dev/null | wc -l
