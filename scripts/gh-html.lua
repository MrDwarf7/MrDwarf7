-- Convert typst raw() strings tagged with the "@@GH_HTML@@" sentinel into raw HTML
-- output. This replaces the old `tr -d '`'` hack in convert.sh, which globally
-- stripped backticks (corrupting any legitimate inline code).
--
-- pandoc's typst reader discards the `lang` attribute on raw(), so github-profile.typ
-- wraps HTML payloads with gh_html(), which prepends the sentinel. Here we strip the
-- sentinel and emit RawInline/RawBlock html, leaving every other code span untouched.
local marker = "@@GH_HTML@@"

function Code(elem)
  local s = elem.text
  if s:sub(1, #marker) == marker then
    return pandoc.RawInline("html", s:sub(#marker + 1))
  end
  return elem
end

function CodeBlock(elem)
  local s = elem.text
  if s:sub(1, #marker) == marker then
    return pandoc.RawBlock("html", s:sub(#marker + 1))
  end
  return elem
end
