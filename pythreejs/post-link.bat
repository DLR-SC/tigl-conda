@echo off

(
  "%PREFIX%\Scripts\jupyter-nbextension.exe" enable pythreejs --py --sys-prefix
) >>"%PREFIX%\.messages.txt" 2>&1
