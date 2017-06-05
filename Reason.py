import re, os
import sublime, sublime_plugin
from subprocess import Popen, PIPE
from collections import namedtuple

# If the user didn't set the path to refmt correctly, at least guess that it's
# here V
os.environ['PATH'] += ':/usr/local/bin/'

# Portions Copyright (c) 2015-present, Facebook, Inc. All rights reserved.

ERROR_RE = re.compile(
    r'^File "(?P<file_name>.*)", line (?P<line>\d+), characters (?P<col>\d+)-\d+:$\r?\n'
    r'^Error: (?P<message>.+)$',
    re.MULTILINE
)

def is_interface(file_name):
    if file_name is None:
        # Should we assume it's an interface or implementation?
        raise Exception('Need file name')
    elif file_name.endswith('.rei'):
        return 'true'
    elif file_name.endswith('.re'):
        return 'false'
    else:
        raise Exception('Not a reason file: {}'.format(file_name))

class ReasonFormatCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        settings = sublime.load_settings('Preferences.sublime-settings')
        max_width = str(settings.get('reason_max_width', 100))
        file_name = self.view.file_name();
        refmt = settings.get('path_to_refmt', 'refmt')

        try:
            proc = Popen([
                refmt,
                '--parse', 're',
                '--interface', is_interface(file_name),
                '--print', 're',
                '--print-width', max_width,
            ], stdin=PIPE, stdout=PIPE, stderr=PIPE)
        except FileNotFoundError:
            error = 'Can\'t find the Reason formatting binary `%s` ($PATH=%s).\n\n' \
                'You can set it in your preferences (cmd+,) ' \
                'by adding "path_to_refmt": "/path/to/it".' \
                % (refmt, os.environ['PATH'])
            sublime.error_message(error)
            return

        region = sublime.Region(0, self.view.size())
        source = self.view.substr(region)
        (stdout, stderr) = proc.communicate(bytes(source, 'utf8'))

        if len(stdout) > 0:
            formatted = stdout.decode('utf8')
            if source != formatted:
                self.view.replace(edit, region, formatted)
            else:
                sublime.status_message('Already formatted')
        else:
            match = ERROR_RE.match(stderr.decode('utf8'))
            if match:
                line = int(match.group('line'))
                col = int(match.group('col'))
                start = self.view.text_point(line - 1, col)
                self.view.sel().clear()
                self.view.sel().add(sublime.Region(start))
                self.view.show(start)

            self.view.run_command('sublimelinter_lint')


from SublimeLinter.lint import Linter

class Reason(Linter):
    syntax = 'reason'

    # Hack to make SublimeLinter happy, we build real command line in `cmd`
    executable = 'cat'

    regex = ERROR_RE
    multiline = True
    line_col_base = (1, 0)

    def cmd(self):
        file_name = self.view.file_name();
        settings = sublime.load_settings('Preferences.sublime-settings')
        return [
            settings.get('path_to_refmt', 'refmt'),
            '--parse', 're',
            '--interface', is_interface(file_name),
            self.view.file_name(),
            '--print', 'none'
        ]
