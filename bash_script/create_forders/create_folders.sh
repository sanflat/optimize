#!/bin/bash

# ベースディレクトリのパス
base_directory="$1"

# ディレクトリが存在するかどうかをチェック
if [ ! -d "$base_directory" ]; then
    echo "Error: Base directory does not exist at: $base_directory" >&2
    exit 1
fi

# 各種フォルダを作成するための関数
create_folders() {
    local folder_paths=("$@")
    for path in "${folder_paths[@]}"; do
        full_path="$base_directory/$path"
        mkdir -p "$full_path"
        echo "Created: $full_path"
    done
}

# フォルダを作成するかどうかを尋ねる
ask_and_create() {
    local question="$1"
    local -a paths=("${@:2}")
    echo "$question"
    read -p "Create these folders? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
        create_folders "${paths[@]}"
    else
        echo "Skipped creation."
    fi
}

# 各質問とフォルダパス
ask_and_create "Aフォルダを作成しますか？" "test/testA1" "test/testA2"
ask_and_create "Bフォルダを作成しますか？" "test2/testB1"

# 作成したフォルダの一覧を表示
echo "Created directories:"
find "$base_directory" -type d -print
