#!/bin/bash

# Function to check CPU Compatibility
check_cpu_feature() {
    grep -q "$1" "/proc/cpuinfo"
}

# Function to check CPU levels
check_cpu_level() {
    local level="$1"
    local features=("${@:2}")

    for feature in "${features[@]}"; do
        if ! check_cpu_feature "$feature"; then
            return 1
        fi
    done

    return 0
}

# Function to print supported CPU levels
print_supported_levels() {
    local supported_levels=("${@}")

    if [[ ${#supported_levels[@]} -gt 0 ]]; then
        echo "CPU supports the following x86-64-v levels:"
        for level in "${supported_levels[@]}"; do
            echo "$level"
        done
    else
        echo "CPU does not support any x86-64-v levels."
    fi
}

# Main function
main() {
    local levels=("x86-64-v1" "x86-64-v2" "x86-64-v3" "x86-64-v4")
    local supported_levels=()

    local features=(
        "x86-64-v1 lm cmov cx8 fpu fxsr mmx syscall sse2"
        "x86-64-v2 cx16 lahf popcnt sse4_1 sse4_2 ssse3"
        "x86-64-v3 avx avx2 bmi1 bmi2 f16c fma abm movbe xsave"
        "x86-64-v4 avx512f avx512bw avx512cd avx512dq avx512vl"
    )

    for feature in "${features[@]}"; do
        local level=${feature%% *}
        local feature_list=${feature#* }

        if check_cpu_level "$level" $feature_list; then
            supported_levels+=("$level")
        fi
    done

    print_supported_levels "${supported_levels[@]}"
}

# Call the main function
main
