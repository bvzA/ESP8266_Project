current_dir=$(shell pwd)
bin_dir=$(current_dir)/bin
src_control_panel_path=$(current_dir)/src/control-panel

build: clean
	cd ${src_control_panel_path} && ./gradlew bootJar

install:
	test -f ${src_control_panel_path}/build/libs/control-panel-*.jar || { echo >&2 "need build!!"; exit 1; }
	rm -rf ${bin_dir}/*
	cp -f ${src_control_panel_path}/build/libs/control-panel-*.jar ${bin_dir}/control-panel.jar
	cp -f ${src_control_panel_path}/src/main/shell/* ${bin_dir}/

clean:
	cd ${src_control_panel_path} && ./gradlew clean

check:
	command -v java >/dev/null 2>&1 || { echo >&2 "require java but it's not installed. Aborting."; exit 1; }
