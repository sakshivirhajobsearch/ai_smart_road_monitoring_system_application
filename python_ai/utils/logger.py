import logging

def get_logger(name):
    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)

    if not logger.handlers:
        ch = logging.StreamHandler()
        formatter = logging.Formatter("[%(levelname)s] %(asctime)s - %(message)s")
        ch.setFormatter(formatter)
        logger.addHandler(ch)

    return logger
