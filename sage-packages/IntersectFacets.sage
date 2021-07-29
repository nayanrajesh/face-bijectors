currentpath = os.getcwd()
readpath = os.path.join(currentpath, 'Read.sage')
load(readpath)

print(ReadPosets(4))
