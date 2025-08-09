#!/bin/bash

SIZE_GB=${SIZE_GB:-4}
SIZE_MB=$((SIZE_GB * 1024))
BLOCK_SIZE="1m"
TARGET_DIR="/tmp"

normalize_lang() {
  local code="$1"; code=${code//\"/}
  code=$(echo "$code" | tr '[:upper:]' '[:lower:]')
  case "$code" in
    ru*|russian) echo ru ;;
    en*|english) echo en ;;
    zh*|cn|chinese) echo zh ;;
    zh_tw*|tw|traditional) echo zh ;;
    hi*|hindi|in) echo hi ;;
    es*|spanish) echo es ;;
    *) echo en ;;
  esac
}

get_lang() {
  if [[ -n "${DISK_TEST_LANG:-}" ]]; then
    normalize_lang "$DISK_TEST_LANG"; return
  fi
  local l="${LC_ALL:-${LC_MESSAGES:-${LANG:-}}}"
  if [[ -n "$l" ]]; then
    l=${l%%.*}; l=${l%%_*}
    normalize_lang "$l"; return
  fi
  local langs
  langs=$(defaults read -g AppleLanguages 2>/dev/null)
  echo "$langs" | grep -qi '"ru' && { echo ru; return; }
  echo "$langs" | grep -qi '"zh' && { echo zh; return; }
  echo "$langs" | grep -qi '"hi' && { echo hi; return; }
  echo "$langs" | grep -qi '"es' && { echo es; return; }
  echo en
}

case "$(get_lang)" in
  ru)
  TITLE="🚀 Тест скорости диска (${SIZE_GB} ГБ)"
  SEP="================================"
  MSG_CLEAR_CACHE="Очистка системного кэша..."
  MSG_WRITE_TEST="📝 Тестирование скорости записи..."
  MSG_WRITE_SPEED="✅ Запись"
  MSG_CLEAR_BEFORE_READ="Очистка кэша перед тестом чтения..."
  MSG_READ_TEST="📖 Тестирование скорости чтения..."
  MSG_READ_SPEED="✅ Чтение"
  MSG_RESULTS_HEADER="📊 РЕЗУЛЬТАТЫ ТЕСТА ДИСКА:"
  MSG_FILE_SIZE="Размер файла"
  MSG_WRITE="Скорость записи"
  MSG_READ="Скорость чтения"
  MSG_REMOVED="🗑️ Тестовый файл удален"
  UNIT_MB="МБ/с"
  UNIT_GB="ГБ"
  MSG_SYS_HEADER="ℹ️ Система"
  MSG_MODEL="Модель"
  MSG_CHIP="Чип/CPU"
  MSG_CORES_L="Логических ядер"
  MSG_CORES_P="Физических ядер"
  MSG_RAM="Память"
  MSG_MACOS="macOS"
  MSG_SELECT_DISK="Выберите том для теста (Enter — внутренний):"
  MSG_OPTION_INTERNAL="Внутренний"
  MSG_NO_EXTERNALS="Внешних томов не найдено. Тестирую внутренний."
  MSG_READONLY_FALLBACK="Выбранный том только для чтения. Использую внутренний."
  MSG_INVALID_CHOICE="Неверный выбор. Введите число 1-"
  ;;
  zh)
  TITLE="🚀 磁盘速度测试 (${SIZE_GB} GB)"
  SEP="================================"
  MSG_CLEAR_CACHE="正在清理系统缓存..."
  MSG_WRITE_TEST="📝 正在测试写入速度..."
  MSG_WRITE_SPEED="✅ 写入"
  MSG_CLEAR_BEFORE_READ="在读取测试前清理缓存..."
  MSG_READ_TEST="📖 正在测试读取速度..."
  MSG_READ_SPEED="✅ 读取"
  MSG_RESULTS_HEADER="📊 磁盘测试结果："
  MSG_FILE_SIZE="文件大小"
  MSG_WRITE="写入速度"
  MSG_READ="读取速度"
  MSG_REMOVED="🗑️ 测试文件已删除"
  UNIT_MB="MB/s"
  UNIT_GB="GB"
  MSG_SYS_HEADER="ℹ️ 系统"
  MSG_MODEL="型号"
  MSG_CHIP="芯片/CPU"
  MSG_CORES_L="逻辑核心"
  MSG_CORES_P="物理核心"
  MSG_RAM="内存"
  MSG_MACOS="macOS"
  MSG_SELECT_DISK="选择要测试的卷 (回车=内部)："
  MSG_OPTION_INTERNAL="内部"
  MSG_NO_EXTERNALS="未发现外部卷，将测试内部卷。"
  MSG_READONLY_FALLBACK="所选卷为只读，改用内部卷。"
  MSG_INVALID_CHOICE="无效选择。请输入 1-"
  ;;
  hi)
  TITLE="🚀 डिस्क स्पीड टेस्ट (${SIZE_GB} GB)"
  SEP="================================"
  MSG_CLEAR_CACHE="सिस्टम कैश साफ़ किया जा रहा है..."
  MSG_WRITE_TEST="📝 लिखने की गति का परीक्षण..."
  MSG_WRITE_SPEED="✅ लिखना"
  MSG_CLEAR_BEFORE_READ="पढ़ने के परीक्षण से पहले कैश साफ़..."
  MSG_READ_TEST="📖 पढ़ने की गति का परीक्षण..."
  MSG_READ_SPEED="✅ पढ़ना"
  MSG_RESULTS_HEADER="📊 डिस्क टेस्ट परिणाम:"
  MSG_FILE_SIZE="फ़ाइल आकार"
  MSG_WRITE="लिखने की गति"
  MSG_READ="पढ़ने की गति"
  MSG_REMOVED="🗑️ टेस्ट फ़ाइल हटाई गई"
  UNIT_MB="MB/s"
  UNIT_GB="GB"
  MSG_SYS_HEADER="ℹ️ सिस्टम"
  MSG_MODEL="मॉडल"
  MSG_CHIP="चिप/CPU"
  MSG_CORES_L="लॉजिकल कोर"
  MSG_CORES_P="फिजिकल कोर"
  MSG_RAM="मेमोरी"
  MSG_MACOS="macOS"
  MSG_SELECT_DISK="टेस्ट के लिए वॉल्यूम चुनें (एंटर=आंतरिक):"
  MSG_OPTION_INTERNAL="आंतरिक"
  MSG_NO_EXTERNALS="कोई बाहरी वॉल्यूम नहीं मिला, आंतरिक पर परीक्षण।"
  MSG_READONLY_FALLBACK="चयनित वॉल्यूम केवल-पढ़ने योग्य है, आंतरिक का उपयोग।"
  MSG_INVALID_CHOICE="अमान्य चयन। 1- दर्ज करें: "
  ;;
  es)
  TITLE="🚀 Prueba de velocidad de disco (${SIZE_GB} GB)"
  SEP="================================"
  MSG_CLEAR_CACHE="Limpiando cachés del sistema..."
  MSG_WRITE_TEST="📝 Probando velocidad de escritura..."
  MSG_WRITE_SPEED="✅ Escritura"
  MSG_CLEAR_BEFORE_READ="Limpiando cachés antes de la prueba de lectura..."
  MSG_READ_TEST="📖 Probando velocidad de lectura..."
  MSG_READ_SPEED="✅ Lectura"
  MSG_RESULTS_HEADER="📊 RESULTADOS DE LA PRUEBA:"
  MSG_FILE_SIZE="Tamaño del archivo"
  MSG_WRITE="Velocidad de escritura"
  MSG_READ="Velocidad de lectura"
  MSG_REMOVED="🗑️ Archivo de prueba eliminado"
  UNIT_MB="MB/s"
  UNIT_GB="GB"
  MSG_SYS_HEADER="ℹ️ Sistema"
  MSG_MODEL="Modelo"
  MSG_CHIP="Chip/CPU"
  MSG_CORES_L="Núcleos lógicos"
  MSG_CORES_P="Núcleos físicos"
  MSG_RAM="Memoria"
  MSG_MACOS="macOS"
  MSG_SELECT_DISK="Seleccione volumen a probar (Enter=interno):"
  MSG_OPTION_INTERNAL="Interno"
  MSG_NO_EXTERNALS="No se encontraron volúmenes externos. Probando el interno."
  MSG_READONLY_FALLBACK="El volumen seleccionado es de solo lectura. Usando el interno."
  MSG_INVALID_CHOICE="Selección inválida. Ingrese 1-"
  ;;
  *)
  TITLE="🚀 Disk speed test (${SIZE_GB} GB)"
  SEP="================================"
  MSG_CLEAR_CACHE="Clearing system caches..."
  MSG_WRITE_TEST="📝 Testing write speed..."
  MSG_WRITE_SPEED="✅ Write"
  MSG_CLEAR_BEFORE_READ="Clearing caches before read test..."
  MSG_READ_TEST="📖 Testing read speed..."
  MSG_READ_SPEED="✅ Read"
  MSG_RESULTS_HEADER="📊 DISK TEST RESULTS:"
  MSG_FILE_SIZE="File size"
  MSG_WRITE="Write speed"
  MSG_READ="Read speed"
  MSG_REMOVED="🗑️ Test file removed"
  UNIT_MB="MB/s"
  UNIT_GB="GB"
  MSG_SYS_HEADER="ℹ️ System"
  MSG_MODEL="Model"
  MSG_CHIP="Chip/CPU"
  MSG_CORES_L="Logical cores"
  MSG_CORES_P="Physical cores"
  MSG_RAM="Memory"
  MSG_MACOS="macOS"
  MSG_SELECT_DISK="Select volume to test (Enter=internal):"
  MSG_OPTION_INTERNAL="Internal"
  MSG_NO_EXTERNALS="No external volumes found. Testing internal."
  MSG_READONLY_FALLBACK="Selected volume is read-only. Using internal."
  MSG_INVALID_CHOICE="Invalid choice. Enter 1-"
  ;;
esac

echo "$TITLE"
echo "$SEP"

# System info
MODEL=$(sysctl -n hw.model 2>/dev/null)
CPU_BRAND=$(sysctl -n machdep.cpu.brand_string 2>/dev/null)
CPU_LOGICAL=$(sysctl -n hw.logicalcpu 2>/dev/null)
CPU_PHYSICAL=$(sysctl -n hw.physicalcpu 2>/dev/null)
MEM_BYTES=$(sysctl -n hw.memsize 2>/dev/null)
MEM_GB=$(echo "scale=1; $MEM_BYTES/1024/1024/1024" | bc)
OS_VER=$(sw_vers -productVersion 2>/dev/null)
OS_BUILD=$(sw_vers -buildVersion 2>/dev/null)
if [[ -z "$CPU_BRAND" ]]; then
  CPU_BRAND="Apple Silicon"
fi

echo "$MSG_SYS_HEADER:"
echo "- $MSG_MODEL: ${MODEL:-n/a}"
echo "- $MSG_CHIP: ${CPU_BRAND:-n/a}"
echo "- $MSG_CORES_L: ${CPU_LOGICAL:-n/a}"
echo "- $MSG_CORES_P: ${CPU_PHYSICAL:-n/a}"
echo "- $MSG_RAM: ${MEM_GB:-n/a} $UNIT_GB"
echo "- $MSG_MACOS: ${OS_VER:-n/a} (${OS_BUILD:-n/a})"
echo "$SEP"

# Find external, mounted, writable volumes (robust for APFS/synthesized)
get_external_mounts() {
  for mp in /Volumes/*; do
    [[ -d "$mp" ]] || continue
    dev=$(df "$mp" 2>/dev/null | awk 'NR==2 {print $1}')
    [[ -n "$dev" ]] || continue
    info=$(diskutil info "$dev" 2>/dev/null)
    echo "$info" | grep -Eq "Device Location:\s*External|External:\s*Yes|Internal:\s*No|Removable Media:\s*Removable|Protocol:\s*(USB|Thunderbolt|FireWire|SD)" || continue
    printf "%s\n" "$mp"
  done | sort -u
}

# Build selection menu if external volumes are present
EXTERNAL_MOUNTS=()
while IFS= read -r _mp; do
  EXTERNAL_MOUNTS+=("$_mp")
done < <(get_external_mounts)

if (( ${#EXTERNAL_MOUNTS[@]} > 0 )); then
  echo "$MSG_SELECT_DISK"
  echo "1) $MSG_OPTION_INTERNAL (/tmp)"
  idx=2
  for mp in "${EXTERNAL_MOUNTS[@]}"; do
    echo "$idx) $(basename "$mp") — $mp"
    idx=$((idx+1))
  done
  while true; do
    printf "> "
    read -r choice
    # default internal on empty or explicit 1
    [[ -z "$choice" || "$choice" == 1 ]] && break
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 2 && choice < idx )); then
      TARGET_DIR="${EXTERNAL_MOUNTS[$((choice-2))]}"
      if ! ( : > "$TARGET_DIR/.disk_speed_write_test_$$" 2>/dev/null ); then
        echo "$MSG_READONLY_FALLBACK"
        TARGET_DIR="/tmp"
      else
        rm -f "$TARGET_DIR/.disk_speed_write_test_$$"
      fi
      break
    fi
    echo "$MSG_INVALID_CHOICE$((idx-1))."
  done
else
  echo "$MSG_NO_EXTERNALS"
fi

TESTFILE="$TARGET_DIR/disk_speed_test_${SIZE_GB}gb.tmp"

echo "$MSG_CLEAR_CACHE"
if [[ -z "${DISK_TEST_NO_PURGE:-}" ]]; then
  sudo purge
fi

echo "$MSG_WRITE_TEST"
sync
START_TIME=$(date +%s.%N)
dd if=/dev/zero of="$TESTFILE" bs=$BLOCK_SIZE count=$SIZE_MB 2>/dev/null
sync
END_TIME=$(date +%s.%N)
WRITE_TIME=$(echo "$END_TIME - $START_TIME" | bc)
WRITE_SPEED=$(echo "scale=2; $SIZE_MB / $WRITE_TIME" | bc)
echo "$MSG_WRITE_SPEED: ${WRITE_SPEED} $UNIT_MB"

echo "$MSG_CLEAR_BEFORE_READ"
if [[ -z "${DISK_TEST_NO_PURGE:-}" ]]; then
  sudo purge
fi
sync

echo "$MSG_READ_TEST"
START_TIME=$(date +%s.%N)
dd if="$TESTFILE" of=/dev/null bs=$BLOCK_SIZE 2>/dev/null
END_TIME=$(date +%s.%N)
READ_TIME=$(echo "$END_TIME - $START_TIME" | bc)
READ_SPEED=$(echo "scale=2; $SIZE_MB / $READ_TIME" | bc)
echo "$MSG_READ_SPEED: ${READ_SPEED} $UNIT_MB"

echo
echo "$MSG_RESULTS_HEADER"
echo "=========================="
echo "$MSG_FILE_SIZE: ${SIZE_GB} $UNIT_GB"
echo "$MSG_WRITE: ${WRITE_SPEED} $UNIT_MB"
echo "$MSG_READ: ${READ_SPEED} $UNIT_MB"

rm -f "$TESTFILE"
echo "$MSG_REMOVED"
