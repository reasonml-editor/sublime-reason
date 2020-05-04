import sublime
import sublime_plugin
import subprocess
import re
import os

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

    filename = self.view.file_name()

    # TODO: lookup bsconfig.json/package.json directory
    # workingDir = os.path.dirname(os.path.dirname(filename))

    SETTINGS_PATH = 'Default.sublime-settings'
    napkinExe = sublime.load_settings(SETTINGS_PATH).get('formatterLocation')

    if napkinExe is None or napkinExe == '':
      sublime.error_message("Provide the location of napkinscript.exe in 'formatterLocation'")

    # formatting --------------------------------------------------------------------------------------------------------------------------------

    proc = subprocess.Popen(
      [napkinExe, "-print", "ns", "-report", "plain"],
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
        filename = match.group(1)
        startCnum = int(match.group(2))
        endCnum = int(match.group(3))
        explanation = match.group(4)

        region = sublime.Region(startCnum, endCnum)
        regions.append(region)
        html = '<body id="my-plugin-feature"> <style> div.error {padding: 5px; } </style> <div class="error">' + explanation +  '</div> </body>'
        self.view.add_phantom("errns", region, html, sublime.LAYOUT_BELOW)

      self.view.add_regions('syntaxerror', regions, 'invalid.illegal', 'dot', sublime.DRAW_NO_FILL)
