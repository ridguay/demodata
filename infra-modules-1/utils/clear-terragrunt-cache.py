from pathlib import Path
import os, stat
import shutil

root = '' #If path is longer than 260characters use the \\?\ -> escaped \\\\?\\, example:u'\\\\?\\C:\\Users\\M67J355\\OneDrive - NN\\Documents\\Code\\infra-modules-1\\terraform\\environments\\sbx\pensions'

def remove_readonly(func, path, _):
    "Clear the readonly bit and reattempt the removal"
    os.chmod(path, stat.S_IWRITE)
    func(path)




for path, dirs, files in os.walk(root, topdown=True):
    for name in dirs:
        if os.path.exists(path) and os.path.isdir(path) and path.endswith(".terragrunt-cache") :
           print(path)
           shutil.rmtree(path, onerror=remove_readonly ) 
