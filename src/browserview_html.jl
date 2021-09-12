#==============================================================================
    Open an HTML string in browser as a temp file

    author:     mahiki@users.noreply.github.com
=============================================================================#

"""
    browserview_html(html_string::String)

Open an html string as a temp file in local system, usually defaul app is a browser.
Useful for interactive work processing html data.
"""
function browserview_html(html_string::String)
    f = tempname()
    io = open("$f.html", "w")
    print(io, html_string)
    close(io)
    run(`open $f.html`)
end
