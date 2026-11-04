-- Keep images that sit alone in a paragraph as plain images: the alt text stays
-- the alt text, and the italic paragraph that follows in the source is the caption.
local function plain(img)
  local alt = pandoc.utils.stringify(img.caption)
  img.attributes["fig-alt"] = nil
  img.caption = {}
  img.attributes["alt"] = alt
  return pandoc.Para({ img })
end

function Figure(fig)
  local blk = fig.content[1]
  if #fig.content == 1 and (blk.t == "Plain" or blk.t == "Para")
     and #blk.content == 1 and blk.content[1].t == "Image" then
    return plain(blk.content[1])
  end
end

function Para(p)
  if #p.content == 1 and p.content[1].t == "Image" and #p.content[1].caption > 0 then
    return plain(p.content[1])
  end
end
