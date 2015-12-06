import fileinput, sys
import os.path

def replace(filein, intext, outtext):
    f = open(filein,'r')
    filedata = f.read()
    f.close()


    newdata = filedata.replace(intext, outtext)

    f = open(filein,'w')
    f.write(newdata)
    f.close()

if __name__ == "__main__":
    assert(len(sys.argv) == 3)

    filename = sys.argv[1]
    libname = sys.argv[2]

    in_text = "lib = ctypes.CDLL(\"%s\")" % libname
    out_text = "lib = ctypes.CDLL(os.path.join(sys.prefix, 'lib', '%s'))" % libname

    replace(filename, in_text, out_text)
    replace(filename, "import sys, ctypes", "import sys, ctypes, os.path")
