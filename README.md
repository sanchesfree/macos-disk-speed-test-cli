## macOS Disk Speed Test CLI — Free Blackmagic Disk Speed Test alternative

Languages: English — Русская версия ниже

Simple open-source CLI benchmark for macOS to measure SSD/HDD/NVMe/External drive read and write speeds. Designed as a lightweight, privacy‑friendly alternative to GUI tools like Blackmagic Disk Speed Test.

- Works on Intel and Apple Silicon (M‑series)
- Measures sequential write/read using a large temporary file
- Interactive volume selection (defaults to internal `/tmp`; auto-fallback if no externals)
- Auto language: English, Russian, Chinese (zh), Hindi (hi), Spanish (es) based on macOS locale (can be forced)
- No data leaves your Mac; no installation required

### Why this tool
- Free, open-source, CLI
- Fast check of internal SSD, USB, Thunderbolt, external drives
- Great for comparing real‑world sustained sequential speeds

### Install & Run
```bash
curl -L -o test-speed.sh https://raw.githubusercontent.com/sanchesfree/macos-disk-speed-test-cli/main/test-speed.sh
chmod +x test-speed.sh
./test-speed.sh           # default 4 GB file
SIZE_GB=8 ./test-speed.sh # optional: change test file size (GB)
# force language (en|ru|zh|hi|es)
DISK_TEST_LANG=en ./test-speed.sh
DISK_TEST_LANG=ru ./test-speed.sh
DISK_TEST_LANG=zh ./test-speed.sh
DISK_TEST_LANG=hi ./test-speed.sh
DISK_TEST_LANG=es ./test-speed.sh
```

Requires `bc` (preinstalled). By default uses `sudo purge` to drop caches for clean measurements. To skip cache purge (and avoid sudo prompt):
```bash
DISK_TEST_NO_PURGE=1 ./test-speed.sh
```

To test an external disk, run the script and select the desired volume from the menu. If no external volumes are found, it automatically tests the internal drive.

### Example output
```
🚀 Disk speed test (4 GB)
================================
Clearing system caches...
📝 Testing write speed...
✅ Write: 3100.25 MB/s
Clearing caches before read test...
📖 Testing read speed...
✅ Read: 3205.40 MB/s

📊 DISK TEST RESULTS:
==========================
File size: 4 GB
Write speed: 3100.25 MB/s
Read speed: 3205.40 MB/s
🗑️ Test file removed
```

### Notes
- Test file path: `/tmp/disk_speed_test_<size>gb.tmp`
- Uses `dd` with 1 MiB blocks for sequential I/O
- Purges caches before write and before read to reduce cache effects
- Results represent sequential throughput, not random IOPS

### SEO keywords
macOS disk speed test, macOS SSD benchmark, NVMe benchmark Mac, Blackmagic Disk Speed Test alternative, free disk speed test macOS, CLI disk benchmark, Apple Silicon M‑series SSD speed, M‑series disk speed, external SSD USB Thunderbolt benchmark

---

## macOS Disk Speed Test CLI — бесплатная альтернатива Blackmagic Disk Speed Test

Простой CLI‑бенчмарк с открытым исходным кодом для macOS, который измеряет скорость последовательной записи и чтения SSD/HDD/NVMe и внешних накопителей. Лёгкая и приватная альтернатива графическим утилитам вроде Blackmagic Disk Speed Test.

- Работает на Intel и Apple Silicon (M‑серии)
- Измеряет последовательную запись/чтение на большом временном файле
- Интерактивный выбор тома (по умолчанию внутренний `/tmp`; авто‑фоллбек при отсутствии внешних)
- Автоязык: en, ru, zh, hi, es по локали macOS (можно принудительно задать)
- Ничего не отправляет в сеть; установка не требуется

### Зачем это нужно
- Бесплатно, open‑source, в терминале
- Быстрая проверка внутреннего SSD, USB, Thunderbolt, внешних дисков
- Подходит для сравнения реальной устойчивой последовательной скорости

### Установка и запуск
```bash
curl -L -o test-speed.sh https://raw.githubusercontent.com/sanchesfree/macos-disk-speed-test-cli/main/test-speed.sh
chmod +x test-speed.sh
./test-speed.sh           # по умолчанию 4 ГБ
SIZE_GB=8 ./test-speed.sh # опционально: размер тестового файла (в ГБ)
# принудительный язык: en|ru|zh|hi|es
DISK_TEST_LANG=en ./test-speed.sh
DISK_TEST_LANG=ru ./test-speed.sh
DISK_TEST_LANG=zh ./test-speed.sh
DISK_TEST_LANG=hi ./test-speed.sh
DISK_TEST_LANG=es ./test-speed.sh
```

Требуется `bc` (предустановлен). По умолчанию используется `sudo purge` для очистки кэша перед измерениями. Чтобы пропустить очистку (и не запрашивать sudo):
```bash
DISK_TEST_NO_PURGE=1 ./test-speed.sh
```

Чтобы протестировать внешний диск, запустите скрипт и выберите том в меню. Если внешние тома не найдены, автоматически будет протестирован внутренний накопитель.

### Пример вывода
```
🚀 Тест скорости диска (4 ГБ)
================================
Очистка системного кэша...
📝 Тестирование скорости записи...
✅ Запись: 3100.25 МБ/с
Очистка кэша перед тестом чтения...
📖 Тестирование скорости чтения...
✅ Чтение: 3205.40 МБ/с

📊 РЕЗУЛЬТАТЫ ТЕСТА ДИСКА:
==========================
Размер файла: 4 ГБ
Скорость записи: 3100.25 МБ/с
Скорость чтения: 3205.40 МБ/с
🗑️ Тестовый файл удален
```

### Примечания
- Тестовый файл: `/tmp/disk_speed_test_<size>gb.tmp`
- Используется `dd` с блоком 1 МБ для последовательных операций
- Очистка кэша перед записью и перед чтением для снижения влияния кэша
- Показатели отражают последовательную пропускную способность, а не случайные IOPS

### SEO‑ключевые слова
тест скорости диска macOS, бенчмарк SSD macOS, NVMe бенчмарк Mac, альтернатива Blackmagic Disk Speed Test, бесплатный тест скорости диска macOS, CLI бенчмарк диска, скорость SSD Apple Silicon M‑серии, скорость диска M‑серии, бенчмарк внешнего SSD USB Thunderbolt


