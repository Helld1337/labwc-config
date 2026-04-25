#!/bin/bash

set -e

pkgs="foot fuzzel labwc mako waybar swaybg wlr-randr wl-clipboard slurp grim cliphist pavucontrol nm-connection-editor nwg-look"

if command -v doas >/dev/null 2>&1; then
    su_cmd="doas"
elif command -v sudo >/dev/null 2>&1; then
    su_cmd="sudo"
else
    exit 1
fi

echo "установка пакетов..."
$su_cmd pacman -S --needed --noconfirm $pkgs

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.themes"

echo "перенос конфигураций..."

if [ -d "config" ]; then
    cp -a config/. "$HOME/.config/"
else
    echo "предупреждение: директория 'config' не найдена"
fi

if [ -d "theme" ]; then
    cp -a theme/. "$HOME/.themes/"
else
    echo "предупреждение: директория 'theme' не найдена"
fi

echo "установка завершена."
