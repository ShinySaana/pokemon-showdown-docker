#!/usr/bin/env python3

import glob
import io
import os

from collections import defaultdict
from pathlib import Path
from string import Template

import jinja2
from ruamel.yaml import YAML
yaml=YAML(typ='safe')

def get_main_config_file_raw(path):
    with open(path, "r") as f:
        file_content = f.read()
        return file_content

# https://stackoverflow.com/a/73970721
def expand_posix_vars(posix_expr, context):
    env = defaultdict(lambda: '')
    env.update(context)
    return Template(posix_expr).substitute(env)

def read_main_config_rendered(rendered):
    with io.StringIO(rendered) as f:
        return yaml.load(f)

def recursively_do_on_dict(data, destination, ld):
    current_dict = data
    keys = destination.split(".")
    for current_key in keys[:-1]:
        if current_key not in current_dict:
            current_dict[current_key] = {}
        current_dict = current_dict[current_key]

    return ld(current_dict, keys[-1])

def load_files_from_main_config(main_config):
    to_load = {
        'login.private_key_path': 'login.private_key',
        'login.public_key_path': 'login.public_key',
    }

    for (filepath_key, main_config_dest) in to_load.items():
        get_value = lambda d, k: d[k]
        filepath = recursively_do_on_dict(main_config, filepath_key, get_value)
        with open(Path(filepath), 'r') as f:
            file_content = f.read()
            def set_value(d, k):
                d[k] = file_content
            recursively_do_on_dict(main_config, main_config_dest, set_value)

TEMPLATE_DIR = Path("./templates/wip/")
def template_all(main_config):
    jinja_env = jinja2.Environment(
        loader=jinja2.FileSystemLoader("./"),
        variable_start_string="{=",
        variable_end_string="=}"
    )
    for template_path in TEMPLATE_DIR.glob("**/*.j2"):
        template_src = jinja_env.get_template(str(template_path))

        template_content = template_src.render(
            **main_config
        )
        templated_filename = template_path.with_suffix("").relative_to(TEMPLATE_DIR)    
        print(template_content)

main_config_raw = get_main_config_file_raw("./config.yml")
main_config_rendered = expand_posix_vars(main_config_raw, os.environ)
main_config = read_main_config_rendered(main_config_rendered)
load_files_from_main_config(main_config)

template_all(main_config)