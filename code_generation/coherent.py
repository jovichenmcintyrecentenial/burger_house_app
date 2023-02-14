#!/usr/bin/env python
import sys
import os
import os.path
import shutil

class LocalStorage:
    def save(self, directory,filename, data, mode = 'w'):
        path = os.path.dirname(os.path.realpath(__file__))+"/"+directory
        location = path+"/"+filename
        print(location)
        if not os.path.isdir(path):
            os.mkdir(path)
        file = open(location, mode)
        file.write(data)
        file.close()

    def get(self, directory,filename):
        path = os.path.dirname(os.path.realpath(__file__))+"/"+directory
        location = path+"/"+filename
        print(location)
        all_of_it = ""
        # Open a file: file
        try:

            file = open(location,mode='r')
            all_of_it = file.read()
            #.replace('\n', '')
            file.close()

        except FileNotFoundError as not_found:
            print("Error file not found at "+not_found.filename)
        return all_of_it

    def existDir(self,directory):
        path = os.path.dirname(os.path.realpath(__file__))+"/"+directory
        if not os.path.exists(path):
            return False
        
        return True

x = 0

className = ""
domainName = ""
classFileName = ""

hasProvider = False

for arg in sys.argv:
    #query -c InvitationScreen
   

    if arg=="-p":
        hasProvider = True
    if arg=="-c":
        className = sys.argv[x+1]    
    if arg=="-f":
        classFileName = sys.argv[x+1]  
    if arg=="-d":
        domainName = sys.argv[x+1]
    
        
    x = x + 1

def changeData(str):

    str = replace(str, "className", className)
    str = replace(str, "classNameLowerCase", className.lower())

    return str

def replace(str, var, value):
    # code = 'str = str.replace("{{'+var+'}}", "'+value+'")'

    str = str.replace("{{x}}".replace('x',var), value)
    # exec(code)
    return str

libPath = "templates/../../lib/"
routePath = "xroute".replace('x',libPath)
domainPath = "x/views/pages/z/".replace('x',libPath).replace('z',domainName)
providerPath = "x/providers/".replace('x',domainPath)

routeFileName = "app_routes.dart"
localStorage = LocalStorage()

pageCode = localStorage.get('templates/','page.template')
pageCode = changeData(pageCode)

providerCode = localStorage.get('templates/','provider.template')
providerCode = changeData(providerCode)

routeCodeTemplate = localStorage.get('templates/','route.template')
routeCodeTemplate = changeData(routeCodeTemplate)


routeCode = localStorage.get(routePath,routeFileName)
routeCode = replace(routeCode,"codeGen","{{codeGen}}\nx".replace('x',routeCodeTemplate))

localStorage.save('x/'.replace('x',domainPath),'x_view.dart'.replace("x",classFileName),pageCode, 'w')

localStorage.save(providerPath,'x_provider.dart'.replace("x",classFileName),providerCode, 'w')

localStorage.save('x/'.replace('x',routePath),routeFileName,routeCode, 'w')

