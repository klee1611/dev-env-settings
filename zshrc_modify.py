#!/usr/bin/env python3
import os

class Modify():
    def __init__(self):
        self.__plugins_set = {
            'git',
            'zsh-autosuggestions',
            'autojump',
            'zsh-completions',
            'zsh-syntax-highlighting'
        }

    def modify(self, old_filename, new_filename):
        plugin_line = False
        with open(old_filename, 'r') as f_read:
            with open(new_filename, 'w') as f_write:
                line = f_read.readline()
                while line:
                    if line.startswith('plugins'):
                        plugin_line = True
                    if not plugin_line:
                        f_write.write(line)
                        line = f_read.readline()
                        continue

                    start_idx = 0
                    end_idx = len(line)
                    try:
                        start_idx = line.index('(') + 1
                    except ValueError:
                        pass
                    try:
                        end_idx = line.index(')')
                        plugin_line = False
                    except ValueError:
                        pass
                    plugin_str = line[start_idx:end_idx]
                    plugins = [plugin.strip() for plugin in plugin_str.split()]

                    for plugin in plugins:
                        if plugin != '':
                            self.__plugins_set.add(plugin)

                    if not plugin_line:
                        f_write.write('plugins=(\n')
                        for plugin in self.__plugins_set:
                            f_write.write(f'\t{plugin}\n')
                        f_write.write(')\n')

                    line = f_read.readline()

if __name__ == '__main__':
    modify = Modify()
    modify.modify(f'{os.getenv("HOME")}/.zshrc', '/tmp/.zshrc')
    os.rename('/tmp/.zshrc', f'{os.getenv("HOME")}/.zshrc')
