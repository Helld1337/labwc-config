#!/bin/bash

set -e

# Список пакетов
pkgs="foot fuzzel labwc mako waybar swaybg wlr-randr wl-clipboard slurp grim cliphist pavucontrol nm-connection-editor"

# Проверка утилиты повышения привилегий
if command -v doas >/dev/null 2>&1; then
    su_cmd="doas"
elif command -v sudo >/dev/null 2>&1; then
    su_cmd="sudo"
else
    echo "ошибка: не найден ни sudo, ни doas" >&2
    exit 1
fi

# Установка пакетов (флаг --needed пропускает уже установленные)
echo "установка пакетов..."
$su_cmd pacman -S --needed --noconfirm $pkgs

# Создание целевых директорий, если их нет
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.themes"

# Перенос конфигураций
echo "перенос конфигураций..."

# Конструкция /.* позволяет скопировать всё содержимое, включая скрытые файлы
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
