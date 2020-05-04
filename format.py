import sublime
import sublime_plugin
import subprocess
import re
import os

SETTINGS_PATH = 'Default.sublime-settings'

def findBsConfigDirFromFilename(filename):
  currentDir = os.path.dirname(filename)
  while True:
    if os.path.exists(os.path.join(currentDir, "bsconfig.json")):
      return currentDir

    parentDir = os.path.dirname(currentDir)
    if parentDir == currentDir: # reached root
      return None

    currentDir = parentDir

def findFormatter(self):
  filename = self.view.file_name()
  globalFormatterExe = sublime.load_settings(SETTINGS_PATH).get('optionalGlobalFormatter')

  if filename == None:
    # temp file
    if globalFormatterExe == None or not os.path.exists(globalFormatterExe):
      sublime.error_message(
        "This seems to be a temporary file, which we can format using a global formatter; " +
        "but the package's % s's optionalGlobalFormatter can't be found.\n"% SETTINGS_PATH +
        "Please make sure it exists."
      )
      return None
    else:
      return globalFormatterExe
  else:
    bsconfigDir = findBsConfigDirFromFilename(filename)
    if bsconfigDir == None:
      # bsconfig doesn't exist... gracefully degrade to using the optional global formatter
      # might be bad to do this
      if globalFormatterExe == None or not os.path.exists(globalFormatterExe):
        sublime.error_message(
          "Can't find bsconfig.json in current or parent directories. " +
          "We needed it to determine the location of the formatter.\n" +
          "We fell back to use the package's % s's optionalGlobalFormatter, "% SETTINGS_PATH +
          "but that also can't be found. Please make sure either a " +
          "bsconfig.json or the optionalGlobalFormatter exists."
        )
        return None
      else:
        return globalFormatterExe
    else:
      formatterExe = os.path.join(bsconfigDir, "node_modules", ".bin", "napkinscript")
      if os.path.exists(formatterExe):
        return formatterExe
      else:
        sublime.error_message("Can't find the formatter % s"% formatterExe)
        return None

class NsfmtCommand(sublime_plugin.TextCommand):
  locRegex = re.compile(r'\s+File "(.*)", line (\d+), characters (\d+)-(\d+)')

  def run(self, edit):
    self.view.erase_regions("syntaxerror")
    self.view.erase_phantoms("errns")
    # self.view.erase_regions("dead")

    # View = represents a view into a text buffer
    # region = area of the buffer
    currentBuffer = sublime.Region(0, self.view.size())
    contents = self.view.substr(currentBuffer)

    formatterExe = findFormatter(self)
    if formatterExe == None:
      return

    proc = subprocess.Popen(
      [formatterExe, "-print", "ns", "-report", "plain"],
      stdin=subprocess.PIPE,
      stderr=subprocess.PIPE,
      stdout=subprocess.PIPE,
    )
    stdout, stderr = proc.communicate(contents.encode())

    poorMansErrorParser = re.compile(r'(.*)\((\d+),(\d+)\):(.+)')

    if proc.returncode == 0:
      self.view.replace(edit, currentBuffer, stdout.decode())
    else:
      errTxt = stderr.decode()
      regions = []
      # phantoms = []
      # phantom_set = sublime.PhantomSet(self.view, "napkinsyntax")

      for line in errTxt.splitlines():
        # test.ns(29,38):Did you forget to close this template expression with a backtick?
        match = poorMansErrorParser.match(line)
        if match == None:
          # can't parse error... not sure why. Possible that it's a bad binary
          sublime.error_message("An unknown error occurred during formatting:\n\n" + errTxt)
        else:
          # filename = match.group(1)
          startCnum = int(match.group(2))
          endCnum = int(match.group(3))
          explanation = match.group(4)

          region = sublime.Region(startCnum, endCnum)
          regions.append(region)
          html = '<body id="my-plugin-feature"> <style> div.error {padding: 5px; } </style> <div class="error">' + explanation +  '</div> </body>'
          self.view.add_phantom("errns", region, html, sublime.LAYOUT_BELOW)

      self.view.add_regions('syntaxerror', regions, 'invalid.illegal', 'dot', sublime.DRAW_NO_FILL)
