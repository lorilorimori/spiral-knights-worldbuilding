function Div(el)
  if el.classes:includes("book-citation") then
    local source = el.attributes.source or "Unknown"
    local content = pandoc.utils.stringify(el.content)
    
    local html = string.format([[
<center>
  <div class="book-citation">
    <div class="citation-bg">
      <div class="citation-source"><span>%s</span></div>
      <div class="citation-content">%s</div>
    </div>
  </div>
</center>]], source, content)
    
    return pandoc.RawBlock("html", html)
  end
  return el
end