chalk = require 'chalk'
console.log chalk.blue.bold('QUICKPAGE')

glob = require 'glob'
config = require '../quickpage.conf'
path = require 'path'
fse = require 'fs-extra'
frontMatter = require('front-matter')
hljs = require('highlight.js')
md = require('markdown-it')(
	breaks: true
	xhtmlOut: true
	html: true
	highlight: (str, lang) ->
		if lang and hljs.getLanguage(lang)
			try
				return hljs.highlight(lang, str).value
			catch e

		return ''
)

md.use(require('markdown-it-attrs'))
md.use(require('markdown-it-footnote'))
md.use(require("markdown-it-anchor"))#, { permalink: true, permalinkBefore: true})
md.use(require("markdown-it-toc-done-right"))

filesBuilt = 0

console.log 'working...'

findFiles = ({dest, src, templates}) ->
	glob.sync '**/*.@(md|ejs|html)', {cwd: "#{src}/pages"}

buildFile = (file, {dest, src, templates}) ->
	page = {}
	page.path = path.parse file
	page.dest = path.join(dest, page.path.dir)
	page.metadata = frontMatter fse.readFileSync("#{src}/pages/#{file}", 'utf-8')
	page.html = md.render page.metadata.body
	page.name = page.path.name
	page.template = page.metadata.template or 'default'

	fse.mkdirsSync page.dest
	fse.writeFileSync "#{page.dest}/#{page.name}.html", page.html
	filesBuilt++
	return

prepare = ({dest, src, templates}) ->
	fse.emptyDirSync dest

cleanup = ({dest, src, templates}) ->

# Prepare for build
prepare(config)

# Build each file
buildFile(file, config) for file in findFiles(config)

# Cleanup
cleanup(config)

console.log chalk.green('DONE!')
console.log "Wrote #{filesBuilt} files to #{config.dest}."
