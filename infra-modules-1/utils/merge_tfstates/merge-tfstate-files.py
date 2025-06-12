import sys
import json
import yaml
import uuid
import os
import shutil

def load_tfstate(merge_path, module, file_path):
    print(f'Loading tfstate for {file_path}')

    with open(f'{merge_path}input/{file_path}', 'r') as f:
        state = json.load(f)

    resources = state.get('resources', [])
    if module and resources:
        for i in range(len(resources)):
            resources[i]['module'] = f"module.{module}"
        state['resources'] = resources

    return state


def write_tfstate(merge_path, module, file_path, tfstate):
    print(f'Writing tfstate for {module}')
    with open(f'{merge_path}output/{file_path}', 'w') as f:
        return json.dump(obj=tfstate, fp=f, indent=4)

def move_state_folder(merge_path, input, output, module=""):   
    _, input = input[0]  # trim off module, never relevant if moving
    input_path = f'{merge_path}input/{input}'
    output_path = f'{merge_path}output/{output}'
    if os.path.isfile(output_path):
        os.remove(output_path)
    if os.path.isfile(f'{input_path}.tfstate'):
        out = f'{output_path}/{module}.tfstate'
        new_location = shutil.copy2(f'{input_path}.tfstate', out)
    else:
        new_location = shutil.copytree(input_path, output_path, dirs_exist_ok=True)
    print(f"Moved module {input_path} to {new_location} instead of merging.")

def move_adf_payloads_states(merge_path, input, output):
    _, input = input[0]  # trim off module, never relevant if moving
    input_path = f"{merge_path}input/{input.replace('adf_deploy_component_payloads', '')}"
    output_path = f"{merge_path}output/{output.replace('adf_deploy_component_payloads', '')}"
    for file in os.listdir(input_path):
        if 'adf_deploy_component_payloads' in file:
            input_file_path = os.path.join(input_path, file)
            output_file_path = os.path.join(output_path, file)
            shutil.copy2(input_file_path, output_file_path)

def rename_outputs(module, outputs):
    # Any outputs that have been renamed in the new setup should be modified here
    if module == 'databricks_1':
        outputs['databricks_workspace_id'] = outputs['id']
        del outputs['id']
    if module == 'databricks_2':
        outputs['cluster_ids'] = outputs['ids']
        del outputs['ids']
        outputs['databricks_pat'] = outputs['pat']
        del outputs['pat']
    if module == 'databricks':
        outputs['execute_sql_query_path'] = { 
            'value': 'Not available',
            'type': 'string'   
        }
        if 'ids' in outputs.keys():
            outputs['user_specific_cluster_ids'] = outputs['ids']
            outputs['user_specific_cluster_packages'] = outputs['packages']
            del outputs['ids']
            del outputs['packages']
    

    return outputs


def merge_states(state1, state2):
    merged = {}
    # Assuming version and terraform_version are the same or compatible (Needs revision if not)
    merged['version'] = state1['version']
    merged['terraform_version'] = state1['terraform_version']
    # Increment serial for new state version
    merged['serial'] = max(state1['serial'], state2['serial']) + 1
    # Generate new lineage for new state file, reuse in case editing file.
    merged['lineage'] = str(uuid.uuid4())
    # Merge resources and outputs
    merged['outputs'] = {**state1.get('outputs', {}), **state2.get('outputs', {})}
    merged['resources'] = state1['resources'] + state2['resources']

    return merged


# def deduplicate_state(s):
#     resources = s.get('resources', [])
#     d =  {f"{r.get('module'), ''}__{r['mode']}__{r['type']}__{r['name']}": r for r in resources}
#     s['resources'] = list(d.values())
#     return s

def deduplicate_state(s):
    resources = s.get('resources', [])
    d = {}  
    for r in resources:  
        key = f"{r.get('module', '')}__{r['mode']}__{r['type']}__{r['name']}"   
        if key in d and r["name"] == "ls_adf_dbw":
            d[key]["instances"].extend(r["instances"])
        else:
            d[key] = r 
    s['resources'] = list(d.values())
    return s
    

def merge_inputs(merge_path, module, inputs, output):
    if not (inputs and output):
        raise ValueError(f'Input or output state files not filled in for {module}!')

    states = [load_tfstate(merge_path, module, inp) for (module, inp) in inputs] 

    s1 = states.pop()
    while states:
        s2 = states.pop()
        s1 = merge_states( s1, s2)

    s1['outputs'] = rename_outputs(module, s1['outputs'])
    s1 = deduplicate_state(s1)
    write_tfstate(merge_path, module, output, s1) 

    return s1


def main(product_type, env):
    merge_path = "./utils/merge_tfstates/"
    if "merge_tfstates" in os.getcwd():
        print(f"Already in {merge_path}.")
        merge_path = ""

    with open(f'{merge_path}config.yaml', 'r') as f:
        config = yaml.safe_load(f)
    
    product_config = config[product_type]
    for layer, modules in product_config.items():
        print(f'Merging for layer {layer}')
        # Ensure the output dir exists

        if not os.path.exists(f'{merge_path}output/{layer}'):
            os.makedirs(f'{merge_path}output/{layer}')

        if not modules or len(modules) == 0:
            print(f"WARNING: Empty layer {layer}!")
            continue

        for module, module_config in modules.items():
            print(f'Merging tfstate files for {module}')

            inputs, output = module_config['inputs'], module_config['output']

            # Move the statefiles instead of merging when a key "move" is set to true
            if module_config.get("move", False) and module == "adf_deploy_component_payloads" and env in ("dev"):
                move_adf_payloads_states(merge_path=merge_path, input=inputs, output=output)
            elif module_config.get("move", False):
                move_state_folder(merge_path=merge_path, input=inputs, output=output, module=module)
            else:
                merge_inputs(merge_path, module, inputs, output)

if __name__ == '__main__':
    product_type = "domain" #sys.argv[1]
    env = "individual" #sys.argv[2]
    main(product_type, env)
