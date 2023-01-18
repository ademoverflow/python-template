""" Sphinx Configuration File """

# pylint: skip-file
import python_template

project = "python-template"
copyright = "AdemOverflow, All rights reserved"
author = "Adem Usta"
release = python_template.__version__
version = release

extensions = ["myst_parser", "sphinx.ext.autodoc"]

templates_path = ["_templates"]
exclude_patterns = []


html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
