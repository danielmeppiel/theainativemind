-- Append the shared Kit sign-up form (_kit-form.html) to the end of each blog post.
function Pandoc(doc)
  if doc.meta.listing ~= nil then return nil end
  local path = quarto.project.directory .. "/_kit-form.html"
  local f = io.open(path, "r")
  if not f then
    error("subscribe.lua: cannot read " .. path)
  end
  local form = f:read("a")
  f:close()
  local html = '<section class="subscribe" id="subscribe" aria-labelledby="subscribe-title">\n'
    .. '<h2 id="subscribe-title" class="unnumbered unlisted">Get the handbook and new essays by email</h2>\n'
    .. '<p>The Agentic SDLC Handbook arrives right away, then new essays as they are published. Unsubscribe anytime.</p>\n'
    .. form
    .. '</section>\n'
  doc.blocks:insert(pandoc.RawBlock("html", html))
  return doc
end
