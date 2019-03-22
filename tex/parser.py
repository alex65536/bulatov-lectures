import re
import os


def get_latex(filename):
    with open(filename) as f:
        data = f.read()
    """
    rem|remark|rems|remarks - замечания
    """
    return re.compile(r'\\begin{(?:thm|theorem|crl\*?)}.*?\\end{(?:thm|theorem|crl\*?)}', re.DOTALL).findall(data)



"""
Get all *.tex files from all directories in working directory

Have no garantee to work with Windows
"""
# names of LaTeX files   to ignore, ex. "test.tex"
BLACKLIST = []

subfolders = sorted([f.path[1:] for f in os.scandir() if f.is_dir() and f.path[:3] != "./."])
print(subfolders)

old = os.getcwd()
with open('res.tex', 'w+') as f:
    f.write("\makeatletter\n\def\input@path{{../}}\n\makeatother\n\documentclass[../main.tex]{subfiles}\n\n\\begin{document}")

    for folder in subfolders:
        os.chdir(old + folder)
        tex_files = [i for i in os.listdir(os.getcwd()) if i.endswith(".tex")]
        for tex_file in tex_files:
            if tex_file in BLACKLIST:
                continue
            print(tex_file)
            TeXcT = get_latex(tex_file)
            for line in TeXcT:
                f.write(line)
                f.write("\n")

    f.write("\n\\end{document}")
