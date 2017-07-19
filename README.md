### This is a repository for UI testing using Selenium Web Driver and Robot Framework.

#### For the running of new test you should use the command  "robot" to run the tests:

* for the running of all suite tests:
```bash
robot --outputdir Result  suite-ui.robot
```
You can select browser (Google Chrome or Mozilla Firefox) using "" key, e.g:
```bash
robot --outputdir Result --variablefile firefox_resource.yaml suite-ui.robot
```
or
```bash
robot --outputdir Result --variablefile chrome_resource.yaml suite-ui.robot
```
> NOTE: Google Chrome is selected as default browser

* for the running of one test we can write "[Tags]" in RF and gives the name:
```bash
[Tags]        Login
```
and run
```
robot --outputdir Result -i Login suite-ui.robot
```

> NOTE: The command is "--outputdir Result" create a folder in the project where can find (Screenshots, Errors, and other reports)

You can find more information about Robot Framework by this [link](http://robotframework.org/)

In order to show the result of tests it enought to open the file - log.html
