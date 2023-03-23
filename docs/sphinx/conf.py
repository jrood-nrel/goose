import sys

extensions = [ 'sphinx.ext.mathjax']
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
project = u'GOOSE'
copyright = u'(c) 2023, Jon Rood'
author = u'Jon Rood'
version = u'0.1'
release = u'0.1'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
pygments_style = 'sphinx'
todo_include_todos = False
numfig = True
numfig_format = {'figure': '%s', 'table': '%s', 'code-block': '%s'}
html_theme = 'sphinx_rtd_theme'
htmlhelp_basename = 'GOOSEdoc'
latex_elements = { }
latex_documents = [
    (master_doc, 'goose.tex', u'GOOSE Documentation',
     author, 'manual'),
]
texinfo_documents = [
    (master_doc, 'GOOSE', u'GOOSE Documentation',
     author, 'GOOSE', 'One line description of project.',
     'Miscellaneous'),
]
