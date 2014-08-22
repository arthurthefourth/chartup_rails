# Chartup on Rails

Chartup is a simple intuitive language for writing basic chord charts, inspired by [Markdown][1]. It's designed for musicians who want to be able to write out a quick chord chart in real-time, without having to learn a new application or technology. The source for Chartup is available here on Github [separately][2].

This site is a basic editor for Chartup documents, with embedded preview and PDF downloads. User authentication is implemented with [Devise][3]. The design is built using a [Bootswatch][4] template for Bootstrap 3.0.

Much of the chart-generating magic is embedded in the Chartup library (soon to be made into a gem), which turns a Chartup chart into a Lilypond document. The code here builds out a user system for saving and editing charts, with autosave functionality implemented in Javascript. It uses Lilypond to render generated documents and serves them as PNG's and PDF's.

TODO
=========
* Sharing charts with friends
* Improve management of PDF's and PNG's on backend
* Switch to front-end chart rendering with [VexTab][vx]
* Build in new Chartup features

[1]: http://daringfireball.net/projects/markdown/syntax "Markdown Syntax at Daring Fireball"

[2]: https://github.com/arthurthefourth/chartup "Chartup on GitHub"

[3]: https://github.com/plataformatec/devise "Devise on GitHub"

[4]: http://bootswatch.com/ "Bootswatch: Free Themes for Bootstrap"

[vx]: http://www.vexflow.com/vextab/ "VexTab: A Simple Text-Based Language for Music Notation"
