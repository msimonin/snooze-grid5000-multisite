#!/bin/bash
#
# Copyright (C) 2010-2012 Eugen Feller, INRIA <eugen.feller@inria.fr>
#
# This file is part of Snooze, a scalable, autonomic, and
# energy-aware virtual machine (VM) management framework.
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses>.
#

## Internal script settings
script_name=$(basename $0 .sh)
author="Eugen Feller <eugen.feller@inria.fr>"
log_tag="[Snooze-Experiments]"
snooze_client_binary="/usr/bin/snoozeclient"

## Exit codes
error_code=1
success_code=0

## SSH settings
ssh_private_key="$HOME/.ssh/id_rsa.sid"

############# Virtual cluster related settings ########
# User and group
snooze_user="snoozeadmin"
snooze_group="snooze"

## Image and template locations
images_location="/tmp/snooze/images"
templates_location="/tmp/snooze/templates"

## Template name
template_name="debian_kvm.xml"
template_prefix="debian_kvm_"

## Image names
backing_file_type="web"
backing_file_cluster_location="rennes"
backing_file_name="testing-$backing_file_type-vm-snooze-$backing_file_cluster_location.raw"
backing_file_name="debian-context.raw"
copy_on_write_file_prefix="testing-$backing_file_type-vm-snooze-$backing_file_cluster_location-cow-"
copy_on_write_file_prefix="$backing_file_name"


# Context iso file
context_image="context.iso"

max_memory="2097152"
current_memory="2097152"
number_of_virtual_cpus="1"

# Networking settings
bridge_name="br100"

########### Benchmark related settings #############
# Temporary directory
tmp_directory="./tmp"

# Total number of iterations
number_of_iterations=3

# Benchmark directory on source and destination
benchmark_directory="/opt"

# Results settings
results_output_directory="./results"

# mpirun settings
mpirun_output_file="$tmp_directory/mpirun_output.log"

# Snooze client settings
snoozeclient_output="$tmp_directory/snooze_client_out.txt"
virtual_machine_hosts="$tmp_directory/virtual_machine_hosts.txt"

# NAS Parallel Benchmark settings
nas_processes_per_node=1
nas_application="ft"
nas_problem_class="A"
nas_working_directory="$benchmark_directory/NPB3.3.1/NPB3.3-MPI/bin"
nas_binary_name="$nas_application.$nas_problem_class.$nas_processes_per_node"
nas_benchmark_binary="$nas_working_directory/$nas_binary_name"
nas_gnuplot_output_file="$results_output_directory/npb/$nas_binary_name.dat"

# Web benchmarks settings
web_cuncurrency=100
web_number_of_requests=1000
web_gnuplot_output_file="$results_output_directory/web/web.dat"

# Test case 1 settings
number_of_virtual_clusters=11
virtual_machine_interval=50

# Prints the virtual cluster settings
print_virtual_cluster_settings () {   
    echo "<----------------- Virtual Cluster ------------>"
    echo "$log_tag Images location: $images_location"
    echo "$log_tag Templates location: $templates_location"
    echo "$log_tag Backing file name: $backing_file_name"
    echo "$log_tag Virtual machine max memory: $max_memory"
    echo "$log_tag Virtual machine current memory: $current_memory"
    echo "$log_tag Number of virtual cpus: $number_of_virtual_cpus"
    echo "$log_tag Virtual machine network bridge: $bridge_name"
    echo "<------------------------------------------->"
}

# Prints the general benchmark settings
print_general_benchmark_settings () {   
    echo "<----------------- General benchmark settings ---------------->"
    echo "$log_tag Global benchmark directory: $benchmark_directory"
    echo "$log_tag Global temporary directory: $tmp_directory"
    echo "$log_tag Results output directory: $results_output_directory"
    echo "$log_tag Virtual machine hosts file: $virtual_machine_hosts"
    echo "<------------------------------------------------------------->"
}

# Print NAS parallel benchmark settings
print_npb_settings () {   
    echo "<----------------- Nas parallel benchmark settings ------------>"
    echo "$log_tag MPIRUN output file: $mpirun_output_file"
    echo "$log_tag GNUPlot output file: $gnuplot_output_file_npb"
    echo "$log_tag Number of processes per node: $nas_processes_per_node"
    echo "$log_tag Application: $nas_application"
    echo "$log_tag Problem class: $nas_problem_class"
    echo "$log_tag Nodes working directory: $nas_working_directory"
    echo "$log_tag Benchmark directory: $nas_benchmark_directory"
    echo "$log_tag Benchmark binary: $nas_benchmark_binary"
    echo "<-------------------------------------------------------------->"
}

# Prints the web settings
print_web_settings () {
    echo "<------------------- Web benchmark settings -------------------->"
    echo "$log_tag Cuncurrentcy: $web_cuncurrency"
    echo "$log_tag Number of requests: $web_number_of_requests" 
    echo "$log_tag Output file: $web_gnuplot_output_file"
    echo "<-------------------------------------------------------------->"
}

# Prints the test case 1 settings
print_test_case_1_settings () {
    echo "<-------------------- Test case 1 settings -------------------->"
    echo "$log_tag Number of virtual clusters: $number_of_virtual_clusters"
    echo "$log_tag Virtual machine interval: $virtual_machine_interval" 
    echo "<-------------------------------------------------------------->"
}

