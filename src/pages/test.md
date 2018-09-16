# Test file
^[Inlines notes are easier to write, since
you don't have to pick an identifier and move down to type the
note.]
```coffeescript
glob = require 'glob'
config = require '../quickpage.conf'
path = require 'path'
fse = require 'fs-extra'
marked = require 'marked'
frontMatter = require('front-matter')
hljs = require('highlight.js')
md = require('markdown-it')(
	breaks: true
	xhtmlOut: false
	html: true
	highlight: (str, lang) ->
		if lang and hljs.getLanguage(lang)
			try
				returnreturn hljs.highlight(lang, str).value
			catch e

		return ''
)

findFiles = ({dest, src, templates}) ->
	glob.sync '**/*.@(md|ejs|html)', {cwd: "#{src}/pages"}

buildFile = (file, {dest, src, templates}) ->
	# Construct the Page object
	page = {}
	page.path = path.parse file
	page.dest = path.join(dest, page.path.dir)
	page.metadata = frontMatter fse.readFileSync("#{src}/pages/#{file}", 'utf-8')
	page.html = md.render page.metadata.body
	page.name = page.path.name
	page.template = page.metadata.template or 'default'



	console.log JSON.stringify page
	fse.mkdirsSync page.dest

	console.log "Writing: #{page.dest}"
	fse.writeFileSync "#{page.dest}/#{page.name}.html", page.html

prepare = ({dest, src, templates}) ->
	fse.emptyDirSync dest

cleanup = ({dest, src, templates}) ->

# Prepare for build
prepare(config)

# Build each file
buildFile(file, config) for file in findFiles(config)

# Cleanup
cleanup(config)

```