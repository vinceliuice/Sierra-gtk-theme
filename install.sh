#!/bin/bash
#set -ueo pipefail
#set -x

REPO_DIR=$(cd $(dirname $0) && pwd)
SRC_DIR=${REPO_DIR}/src

DEST_DIR=/usr/share/themes
THEME_NAME=Sierra
COMPACT_VARIANTS=('' '-compact')
TRANS_VARIANTS=('' '-solid')
COLOR_VARIANTS=('-light' '-dark')
THIN_VARIANTS=('' '-thin')

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-t, --trans VARIANTS..." "Specify theme trans variant(s) [solid] (Default: All variants)"
  printf "  %-25s%s\n" "-c, --color VARIANTS..." "Specify theme color variant(s) [light|dark] (Default: All variants)"
  printf "  %-25s%s\n" "-i, --thin VARIANTS..." "Specify theme trans variant(s) [thin] (Default: All variants)"
  printf "  %-25s%s\n" "-s, --compact VARIANT" "Specify theme compact variant [compact] (Default: All variants)"
  printf "  %-25s%s\n" "-g, --gdm" "Install GDM theme"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
  printf "\n%s\n" "INSTALLATION EXAMPLES:"
  printf "%s\n" "Install all theme variants into ~/.themes"
  printf "  %s\n" "$0 --dest ~/.themes"
  printf "%s\n" "Install all theme variants into ~/.themes including GDM theme"
  printf "  %s\n" "$0 --dest ~/.themes --gdm"
  printf "%s\n" "Install standard theme variant only"
  printf "  %s\n" "$0 --color standard --size standard"
  printf "%s\n" "Install specific theme variants with different name into ~/.themes"
  printf "  %s\n" "$0 --dest ~/.themes --name MyTheme --color light dark --size compact"
}

install() {
  local dest=${1}
  local name=${2}
  local compact=${3}
  local color=${4}
  local trans=${5}
  local thin=${6}

  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}
  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}

  local THEME_DIR=${dest}/${name}${compact}${color}${trans}${thin}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                            ${THEME_DIR}
  cp -r ${REPO_DIR}/COPYING                                                           ${THEME_DIR}
  # Install index.theme
	echo "[Desktop Entry]" >>                                                     ${THEME_DIR}/index.theme
	echo "Type=X-GNOME-Metatheme" >>                                              ${THEME_DIR}/index.theme
	echo "Name=${name}${compact}${color}${trans}${thin}" >>                       ${THEME_DIR}/index.theme
	echo "Comment=An Stylish Gtk+ theme based on Elegant Design" >>               ${THEME_DIR}/index.theme
	echo "Encoding=UTF-8" >>                                                      ${THEME_DIR}/index.theme
	echo "" >>                                                                    ${THEME_DIR}/index.theme
	echo "[X-GNOME-Metatheme]" >>                                                 ${THEME_DIR}/index.theme
	echo "GtkTheme=${name}${compact}${color}${trans}${thin}" >>                   ${THEME_DIR}/index.theme
	echo "MetacityTheme=${name}${compact}${color}${trans}${thin}" >>              ${THEME_DIR}/index.theme
	echo "IconTheme=Adwaita" >>                                                   ${THEME_DIR}/index.theme
	echo "CursorTheme=Adwaita" >>                                                 ${THEME_DIR}/index.theme
	echo "ButtonLayout=close,minimize,maximize:menu" >>                           ${THEME_DIR}/index.theme

  mkdir -p                                                                            ${THEME_DIR}/gnome-shell
  cd ${SRC_DIR}/gnome-shell
  cp -r ${SRC_DIR}/gnome-shell/gnome-shell${color}${trans}.css                        ${THEME_DIR}/gnome-shell/gnome-shell.css
  cp -r ${SRC_DIR}/gnome-shell/{extensions,message-indicator-symbolic.svg,pad-osd.css} ${THEME_DIR}/gnome-shell

  mkdir -p                                                                            ${THEME_DIR}/gnome-shell/assets
  cd ${SRC_DIR}/gnome-shell/assets
  cp -r ${SRC_DIR}/gnome-shell/assets/{dash,dash-placeholder.svg,noise-texture.svg,startup.png,process-working.svg,window-close.svg,window-close-active.svg,toggle-on.svg,more-results.svg,checkbox.svg,key-enter.svg,key-shift-latched-uppercase.svg,key-shift-uppercase.svg} ${THEME_DIR}/gnome-shell/assets
  cp -r ${SRC_DIR}/gnome-shell/assets/activities${color}.svg                          ${THEME_DIR}/gnome-shell/assets/activities.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/no-events${color}.svg                           ${THEME_DIR}/gnome-shell/assets/no-events.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/no-notifications${color}.svg                    ${THEME_DIR}/gnome-shell/assets/no-notifications.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/calendar-arrow-left${color}.svg                 ${THEME_DIR}/gnome-shell/assets/calendar-arrow-left.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/calendar-arrow-right${color}.svg                ${THEME_DIR}/gnome-shell/assets/calendar-arrow-right.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/checkbox-off${color}.svg                        ${THEME_DIR}/gnome-shell/assets/checkbox-off.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/close${color}.svg                               ${THEME_DIR}/gnome-shell/assets/close.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/toggle-off${color}.svg                          ${THEME_DIR}/gnome-shell/assets/toggle-off.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/key-hide${color}.svg                            ${THEME_DIR}/gnome-shell/assets/key-hide.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/key-layout${color}.svg                          ${THEME_DIR}/gnome-shell/assets/key-layout.svg
  cp -r ${SRC_DIR}/gnome-shell/assets/key-shift${color}.svg                           ${THEME_DIR}/gnome-shell/assets/key-shift.svg
  cd ${THEME_DIR}/gnome-shell
  ln -s assets/no-events.svg no-events.svg
  ln -s assets/process-working.svg process-working.svg
  ln -s assets/no-notifications.svg no-notifications.svg

  mkdir -p                                                                            ${THEME_DIR}/gtk-2.0
  cd ${SRC_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/gtkrc${color}                                              ${THEME_DIR}/gtk-2.0/gtkrc
  cp -r ${SRC_DIR}/gtk-2.0/assets${color}                                             ${THEME_DIR}/gtk-2.0/assets
  cp -r ${SRC_DIR}/gtk-2.0/{apps.rc,main.rc,panel.rc,xfce-notify.rc}                  ${THEME_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/menubar-toolbar${color}.rc                                 ${THEME_DIR}/gtk-2.0/menubar-toolbar.rc

  mkdir -p                                                                            ${THEME_DIR}/gtk-3.0
  cd ${SRC_DIR}/gtk-3.0
  cp -r ${SRC_DIR}/gtk-3.0/assets                                                     ${THEME_DIR}/gtk-3.0
	cp -r ${SRC_DIR}/gtk-3.0/thumbnail${compact}${color}.png                      ${THEME_DIR}/gtk-3.0/thumbnail.png
	cp -r ${SRC_DIR}/gtk-3.0/gtk${compact}${color}${trans}${thin}.css             ${THEME_DIR}/gtk-3.0/gtk.css
	cp -r ${SRC_DIR}/gtk-3.0/gtk${compact}-dark${trans}${thin}.css                ${THEME_DIR}/gtk-3.0/gtk-dark.css

  mkdir -p                                                                            ${THEME_DIR}/metacity-1
  cd ${SRC_DIR}/metacity-1
  cp -r ${SRC_DIR}/metacity-1/metacity-theme${color}.xml                              ${THEME_DIR}/metacity-1/metacity-theme.xml
  cp -r ${SRC_DIR}/metacity-1/{*.png,*.svg}                                           ${THEME_DIR}/metacity-1
  cd ${THEME_DIR}/metacity-1
	ln -s metacity-theme.xml metacity-theme-1.xml
	ln -s metacity-theme.xml metacity-theme-2.xml
	ln -s metacity-theme.xml metacity-theme-3.xml

  mkdir -p                                                                            ${THEME_DIR}/unity
  cd ${SRC_DIR}
  cp -r ${SRC_DIR}/unity                                                              ${THEME_DIR}

  mkdir -p                                                                            ${THEME_DIR}/xfwm4
  cd ${SRC_DIR}/xfwm4
  cp -r ${SRC_DIR}/xfwm4/assets${color}/*.png                                         ${THEME_DIR}/xfwm4
  cp -r ${SRC_DIR}/xfwm4/themerc${color}                                              ${THEME_DIR}/xfwm4/themerc
}

install_gdm() {
    local THEME_DIR=${1}/${2}${3}${4}${5}${6}
      # bakup and install files related to gdm theme
      if [[ ! -f /usr/share/gnome-shell/gnome-shell-theme.gresource.bak ]]; then
          mv -f /usr/share/gnome-shell/gnome-shell-theme.gresource \
                /usr/share/gnome-shell/gnome-shell-theme.gresource.bak
      fi
      if [[ -f /usr/share/gnome-shell/theme/ubuntu.css ]]; then
          if [[ ! -f /usr/share/gnome-shell/theme/ubuntu.css.bak ]]; then
              mv -f /usr/share/gnome-shell/theme/ubuntu.css \
                     /usr/share/gnome-shell/theme/ubuntu.css.bak
          fi
          cp -af ${THEME_DIR}/gnome-shell/gnome-shell.css \
                 /usr/share/gnome-shell/theme/ubuntu.css
      fi
      glib-compile-resources \
       --sourcedir=${THEME_DIR}/gnome-shell \
       --target=/usr/share/gnome-shell/gnome-shell-theme.gresource \
       ${THEME_DIR}/gnome-shell/gnome-shell-theme.gresource.xml
  echo "Installing 'gnome-shell-theme.gresource'..."
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -g|--gdm)
      gdm=true
      shift 1
      ;;
    -t|--trans)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          solid)
            transs+=("${TRANS_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized trans variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -c|--color)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          light)
            colors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[2]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -t|--thin)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          thin)
            thins+=("${THIN_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized thin variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--size)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          compact)
            transs+=("${SIZE_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

if [[ ! -w "${dest:-${DEST_DIR}}" ]]; then
  echo "Please run as root."
  exit 1
fi

for compact in "${compacts[@]:-${COMPACT_VARIANTS[@]}}"; do
  for trans in "${transs[@]:-${TRANS_VARIANTS[@]}}"; do
    for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
      for thin in "${thins[@]:-${THIN_VARIANTS[@]}}"; do
        install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${compact}" "${color}" "${trans}" "${thin}"
      done
    done
  done
done

if [[ $gdm == true ]]; then
  install_gdm "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${compact}" "${color}" "${trans}" "${thin}"
fi

echo
echo Done.
