#!/bin/bash
choices=($(cat /sys/firmware/acpi/platform_profile_choices))
current=$(cat /sys/firmware/acpi/platform_profile)
for i in "${!choices[@]}"; do
  if [[ "${choices[$i]}" == "$current" ]]; then
    next_index=$(((i + 1) % ${#choices[@]}))
    echo "${choices[$next_index]}" | sudo tee /sys/firmware/acpi/platform_profile >/dev/null
    exit 0
  fi
done
