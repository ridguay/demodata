import yaml
import sys


def main(filename_in, filename_out):
    with open(filename_in, 'r') as f:
        config = yaml.safe_load(f)
    variables = config['variables']

    # Trim the "arm__" part off the variable names for use in the ARM deployment as override parameters
    param_string = " ".join(f"-{var['name'][5:]} \"{var['value']}\"" for var in variables if var['name'].startswith('arm__'))

    with open(filename_out, 'w') as f:
        f.write(param_string)


if __name__ == '__main__':
    f_in, f_out = sys.argv[1], sys.argv[2]
    main(filename_in=f_in, filename_out=f_out)
