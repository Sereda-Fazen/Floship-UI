import time
from os import path, system

from pip import logger


def uploaded_file(file_name):
    file_path_list = path.join(path.join('../FloShip', 'utils'), file_name).split('/')
    for word in file_path_list:
        if word:
            system('xdotool key 61')
            system('xdotool type --delay 30 "{}"'.format(word))
    time.sleep(3)
    system('xdotool key 104')
    logger.info('File "{}" was uploaded successfully'.format(file_name))
