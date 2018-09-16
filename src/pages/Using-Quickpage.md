# Using quickpage

${toc}

Quickpage is a static page generator written in Node.js using markdown for its source material.

[Markdown-it]()
[Highlight.js]()
[markdown-it-attrs]()
[markdown-it-footnotes]()

## Markdown extentions

### Syntax highlighting
Uses Highight.js for syntax-highlighting.

### Custom Attributes
https://www.npmjs.com/package/markdown-it-attrs

### Footnotes
```markdown
Here is a footnote reference,[^1] and another.[^longnote]

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented to show that they
belong to the previous footnote.
Here is an inline note.^[Inlines notes are easier to write, since
you don't have to pick an identifier and move down to type the
note.]

```