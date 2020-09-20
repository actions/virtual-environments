# This script was taken from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/autologin.sh
# Distributed by MIT license, license can be found at the bottom of this script

echo "Enabling automatic GUI login for the '$USERNAME' user.."

python $HOME/bootstrap/kcpassword.py "$PASSWORD"

/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser "$USERNAME"

: '
The MIT License (MIT)
Copyright (c) 2013-2017 Timothy Sutton
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'