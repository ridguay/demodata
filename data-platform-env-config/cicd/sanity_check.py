import yaml
import os


def open_yaml(path):
	with open(path) as stream:
		try:
			return yaml.safe_load(stream)
		except yaml.YAMLError as err:
			raise Exception(f"Something went wrong opening {path}")

def find_yaml_paths(path):
	for root, dirs, files in os.walk(path):
		for name in files:
			if name.endswith("yml"):
				key = f"{root}/{name}"
				yield key


def open_all_yaml(path):
	all_yaml = {}

	for key in find_yaml_paths(path):
		all_yaml[key] = open_yaml(key)

	return all_yaml


def sanity_pipeline_names(yaml_info):
	names = []
	for key, info in yaml_info.items():
		if "name" in info:
			name = info["name"]
			print(f"\t Found pipeline {name}")

			names.append(name)

	assert len(names) == len(set(names)), "Found duplicate names in pipeline names."


if __name__=="__main__":
	print("Checking yaml files in cicd/")

	all_yaml = open_all_yaml("cicd")
	print("Checking pipeline names for uniqueness")
	sanity_pipeline_names(all_yaml)
