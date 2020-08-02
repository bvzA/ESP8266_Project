current_dir=$(shell pwd)
bin_dir=$(current_dir)/bin
dist_dir=$(current_dir)/dist
src_control_panel_path=$(current_dir)/src/control-panel

.PONY: clean check build install

build: clean check
	cd ${src_control_panel_path} && ./gradlew bootJar

release:
	mkdir -p ${dist_dir}
	rm -rf ${dist_dir}/*
	mkdir -p ${dist_dir}/control-panel
	cp -f ${src_control_panel_path}/build/libs/control-panel-*.jar ${dist_dir}/control-panel/control-panel.jar
	cp -f ${src_control_panel_path}/src/main/resources/application-template.properties ${dist_dir}/control-panel/
	cp -f ${src_control_panel_path}/src/main/shell/cpanel ${dist_dir}/control-panel/
	cp -f ${src_control_panel_path}/src/main/shell/control-panel.service ${dist_dir}/control-panel/
	cd ${dist_dir} && tar -zcvf control-panel.tar.gz ./control-panel
	rm -rf ${dist_dir}/control-panel
	
install:
	mkdir -p ${bin_dir} 
	test -f ${src_control_panel_path}/build/libs/control-panel-*.jar || { echo >&2 "need build!!"; exit 1; }
	rm -rf ${bin_dir}/*
	cp -f ${src_control_panel_path}/build/libs/control-panel-*.jar ${bin_dir}/control-panel.jar
	cp -f ${src_control_panel_path}/src/main/shell/* ${bin_dir}/
	cp -f ${src_control_panel_path}/src/main/resources/application.properties ${bin_dir}/
	chown -R iotusr:iotgrp ${bin_dir}

clean:
	cd ${src_control_panel_path} && ./gradlew clean

check:
	command -v java >/dev/null 2>&1 || { echo >&2 "require java but it's not installed. Aborting."; exit 1; }
