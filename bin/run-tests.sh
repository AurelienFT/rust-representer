#!/usr/bin/env sh

# Synopsis:
# Test the representer by running it against a predefined set of solutions 
# with an expected output.

# Output:
# Outputs the diff of the expected representation and mapping against the
# actual representation and mapping generated by the representer.

# Example:
# ./bin/run-tests.sh

exit_code=0

# Iterate over all test directories
for test_dir in $(find tests -mindepth 1 -maxdepth 1 -type d); do
    test_dir_name=$(basename "${test_dir}")
    test_dir_path=$(realpath "${test_dir}")

    bin/run.sh "${test_dir_name}" "${test_dir_path}/" "${test_dir_path}/"

    for file in representation.txt representation.json mapping.json; do
        expected_file="expected_${file}"
        echo "${test_dir_name}: comparing ${file} to ${expected_file}"

        if ! diff "${test_dir_path}/${file}" "${test_dir_path}/${expected_file}"; then
            exit_code=1
        fi
    done
done

exit ${exit_code}
