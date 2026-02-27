-- a.svelte
function Link(el)
  local is_external = not el.target:match("^#") and 
                      not el.target:match("^/") and
                      el.target:match("^https?://")
  
  if is_external then
    el.attributes.target = "_blank"
    el.attributes.rel = "noopener noreferrer"
    return el
  else
    el.attributes.class = (el.attributes.class or "") .. " internal-link"
    return el
  end
end

-- h4.svelte
function Header(el)
  if el.level == 4 then
    local id = pandoc.utils.stringify(el.content):gsub("%s+", "-"):lower()
    
    -- anchor button
    local html = string.format([[
<div class="container-align-anchor">
  <h4 id="%s">%s</h4>
  <h4 data-toc-ignore>
    <button class="anchor" onclick="gotoAnchorHeading(this)">i</button>
  </h4>
</div>]], id, pandoc.utils.stringify(el.content))
    
    return pandoc.RawBlock("html", html)
  end
  return el
end

function Code(el)
  el.attributes.class = (el.attributes.class or "") .. " inline-code"
  return el
end

-- code.svelte
function CodeBlock(el)
  local html = string.format([[
<div class="code-block-wrapper">
  <pre><code class="%s">%s</code></pre>
</div>]], el.classes[1] or "", pandoc.utils.stringify(el.text))
  
  return pandoc.RawBlock("html", html)
end