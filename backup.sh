#!/bin/bash

# Путь к папке, которую нужно скопировать
SOURCE_DIR="/home/script_bash/TEST"

# Путь к директории, куда сохранять резервные копии
BACKUP_DIR="/home/script_bash/backups"

# Имя архива (с датой и временем)
BACKUP_NAME="backup_$(date +'%Y-%m-%d_%H-%M-%S').tar.gz"

# Проверка существования исходной папки
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Ошибка: Папка $SOURCE_DIR не существует."
  exit 1
fi

# Проверка существования директории для резервных копий
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Директория $BACKUP_DIR не существует. Создаю..."
  mkdir -p "$BACKUP_DIR"
fi

# Создание резервной копии
echo "Создание резервной копии $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

# Проверка успешности создания архива
if [ $? -eq 0 ]; then
  echo "Резервная копия успешно создана: $BACKUP_DIR/$BACKUP_NAME"
else
  echo "Ошибка при создании резервной копии."
  exit 1
fi


# Удаление резервных копий старше 1 дней
find "$BACKUP_DIR" -name "backup_*.tar.gz" -type f -mtime +1 -exec rm -f {} \;
echo "Удалены резервные копии старше 1 дней."


LOG_FILE="$BACKUP_DIR/backup.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Резервная копия создана: $BACKUP_NAME" >> "$LOG_FILE"
