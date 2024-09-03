from configparser import ConfigParser
from pathlib import Path

home_path = Path.home()
config_ini_path = str(home_path) + '/.config_semantic_org_roam_search.ini'
config = ConfigParser()
config.read(config_ini_path)
