@echo off

(
  "%PREFIX%\Scripts\jupyter-nbextension.exe" uninstall pythreejs --py --sys-prefix
) >>"%PREFIX%\.messages.txt" 2>&1
