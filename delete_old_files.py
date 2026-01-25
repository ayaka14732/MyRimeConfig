from fnmatch import fnmatch
import os

def load_ignore_patterns(filepath: str) -> tuple[list[str], list[str]]:
    positive_patterns: list[str] = []
    negative_patterns: list[str] = ['/.git']

    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):
                if line.startswith('!'):
                    line = line[1:]
                    patterns = negative_patterns
                else:
                    patterns = positive_patterns

                if not line.startswith('/'):
                    line = '/*/' + line

                patterns.append(line)

    return positive_patterns, negative_patterns

def match_pattern(path: str, patterns: list[str]) -> bool:
    for pattern in patterns:
        if fnmatch(path, pattern):  # TODO: does this apply to dirs also?
            return True
    return False

def match_all_patterns(path: str, positive_patterns: list[str], negative_patterns: list[str]) -> bool:
    return match_pattern(path, positive_patterns) and not match_pattern(path, negative_patterns)

def delete_path(path: str) -> None:
    path = '.' + path
    if os.path.isdir(path):
        os.rmdir(path)
    else:
        os.remove(path)

def run_delete(positive_patterns: list[str], negative_patterns: list[str]) -> None:
    for root, dirs, files in os.walk('.'):
        for path in files + dirs:
            full_path = '/' + os.path.relpath(os.path.join(root, path), '.')
            if match_all_patterns(full_path, positive_patterns, negative_patterns):
                delete_path(full_path)

def main() -> None:
    positive_patterns, negative_patterns = load_ignore_patterns('.rimeignore')
    run_delete(positive_patterns, negative_patterns)

if __name__ == '__main__':
    main()
