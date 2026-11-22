#!/usr/bin/env bash
# Structure check: skill frontmatter, file references, one SKILL.md per folder.
# Usage: scripts/check-skill.sh   (run from anywhere; exits 1 on any error)
set -u
cd "$(dirname "$0")/.."
errors=0
fail() { echo "ERROR: $*"; errors=$((errors + 1)); }

for skill_md in skills/*/SKILL.md; do
  dir=$(dirname "$skill_md")
  dir_name=$(basename "$dir")

  # Frontmatter: first line ---, then name and description before the closing ---
  [ "$(head -n 1 "$skill_md")" = "---" ] || fail "$skill_md: must start with --- frontmatter"
  front=$(awk 'NR==1{next} /^---$/{exit} {print}' "$skill_md")
  name=$(printf '%s\n' "$front" | sed -n 's/^name:[[:space:]]*//p')
  desc=$(printf '%s\n' "$front" | sed -n 's/^description:[[:space:]]*//p')
  [ "$name" = "$dir_name" ] || fail "$skill_md: name '$name' must match folder '$dir_name'"
  printf '%s' "$name" | grep -Eq '^[a-z0-9-]{1,64}$' || fail "$skill_md: name must be lowercase letters, digits, hyphens (max 64)"
  [ -n "$desc" ] || fail "$skill_md: description is missing"
  [ "${#desc}" -le 1024 ] || fail "$skill_md: description is ${#desc} chars (max 1024)"

  # Every `something.md` in backticks must exist, relative to the file that mentions it
  while read -r file; do
    while read -r ref; do
      [ -f "$(dirname "$file")/$ref" ] || fail "$file: references missing file $ref"
    done < <(grep -oE '`[A-Za-z0-9_./-]+\.md`' "$file" | tr -d '`' | sort -u)
  done < <(find "$dir" -name '*.md')
done

# Every folder in skills/ must be a skill (exact name SKILL.md)
for dir in skills/*/; do
  # ls + exact match, because [ -f ] ignores case on macOS
  ls "$dir" | grep -qx 'SKILL.md' || fail "${dir}: missing SKILL.md (exact name, uppercase)"
done

if [ "$errors" -gt 0 ]; then
  echo "$errors error(s)"
  exit 1
fi
echo "OK: all skill checks passed"
